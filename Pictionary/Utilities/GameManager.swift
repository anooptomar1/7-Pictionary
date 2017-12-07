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
}

class GameManager {
	
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
	var currentWord: String? = nil
	lazy var classifier: DrawingClassifier = CNNClassifier()
	var delegate: GameManagerDelegate? = nil
	var canvasPollingTimer: Timer? = nil
	var inGame = false
	
	private init() {}
	
	func prepareSinglePlayerGame() {
		inGame = true
		generateNextWord()
	}
	
	func generateNextWord() {
		currentWord = inGame ? Words.shared.random() : nil
	}
	
	private func startPollingCanvas() {
//		print("startPollingCanvas")
		
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
