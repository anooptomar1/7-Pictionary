//
//  GameManager.swift
//  Pictionary
//
//  Created by Paul Herz on 2017-12-07.
//  Copyright © 2017 Paul Herz. All rights reserved.
//

import Foundation
import TouchDraw

protocol GameManagerDelegate {
	func modelDidGuess(_ guess: String?)
	func countdownDidUpdate(secondsRemaining: Int?)
	func currentWordDidUpdate(_ currentWord: String?)
	func gameStateDidChange(_ gameState: GameState)
}

enum GameState {
	case none, choosingWord, drawing
}

class GameManager {
	
	var navigationController: UINavigationController? = nil
	
	var currentCanvas: TouchDrawView? = nil {
		didSet {
			if currentCanvas != nil {
				startPollingCanvas()
			} else {
				stopPollingCanvas()
			}
		}
	}
	
	static let guessThreshold = 0.5
	static let shared = GameManager()
	var currentWord: String? = nil {
		didSet {
			delegate?.currentWordDidUpdate(currentWord)
		}
	}
	lazy var classifier: DrawingClassifier = CNNClassifier()
	var delegate: GameManagerDelegate? = nil
	var canvasPollingTimer: Timer? = nil
	var secondsRemaining: Int? = nil
	var countdownTimer: Timer? = nil
	
	private var singlePlayer = true
	private var gameState: GameState = .none
	
	private init() {}
	
	func prepareSinglePlayerGame() {
		singlePlayer = true
		gameState = .choosingWord
		generateNextWord()
	}
	
	func generateNextWord() {
		if gameState == .none {
			currentWord = nil
		} else {
			currentWord = Words.shared.random()
		}
	}
	
	func startCountdown() {
		let gameLength = 30
		self.secondsRemaining = gameLength
		self.delegate?.countdownDidUpdate(secondsRemaining: self.secondsRemaining)
		print("\(String(describing: self.secondsRemaining) ?? "—")")
		countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
			self.secondsRemaining = self.secondsRemaining! - 1
			self.delegate?.countdownDidUpdate(secondsRemaining: self.secondsRemaining)
			print("\(String(describing: self.secondsRemaining) ?? "—")")
			if self.secondsRemaining == 0 { self.secondsRemaining = nil; self.stopCountdown() }
		}
	}
	
	func stopCountdown() {
		print("STOP")
		countdownTimer?.invalidate()
		countdownTimer = nil
	}
	
	func goToNextPage() {
		guard let next = nextPageSinglePlayer() else {
			print("Couldn't get next page in game state \(String(describing: gameState))")
			return
		}
		navigationController?.pushViewController(next, animated: true)
	}
	
	private func nextPageSinglePlayer() -> UIViewController? {
		switch gameState {
		case .none:
			return nil
		case .choosingWord:
			return DrawViewController()
		case .drawing:
			return nil
		}
	}
	
	@objc func quit() {
		gameState = .none
		stopCountdown()
		navigationController?.popToRootViewController(animated: true)
	}
	
	private func startPollingCanvas() {
		
		canvasPollingTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
			guard let canvas = self.currentCanvas else { return }
			guard !canvas.exportStack().isEmpty else { return }
			
			self.classifier.classify(drawing: canvas.exportDrawing()) { bestWord, results in
				guard
					let bestWord = bestWord,
					let results = results,
					let bestConfidence = results[bestWord]
				else {
					print("No results.")
					self.delegate?.modelDidGuess(nil)
					return
				}
				
				if bestConfidence > GameManager.guessThreshold {
					self.delegate?.modelDidGuess(bestWord)
				} else {
					self.delegate?.modelDidGuess(nil)
				}
			}
		}
	}
	
	private func stopPollingCanvas() {
		canvasPollingTimer?.invalidate()
		canvasPollingTimer = nil
	}
}
