//
//  DrawViewController.swift
//  Pictionary
//
//  Created by Paul Herz on 2017-12-06.
//  Copyright © 2017 Paul Herz. All rights reserved.
//

import UIKit
import TouchDraw

class DrawViewController: UIViewController {
	
	var currentGuess: String? {
		didSet {
			DispatchQueue.main.async {
				if let currentGuess = self.currentGuess {
					self.drawView.guessBox.label.text = "Is it \(currentGuess.uppercased())?"
				} else {
					self.drawView.guessBox.label.text = "Hmm..."
				}
			}
		}
	}
	
	var currentWord: String? {
		didSet {
			let l = self.drawView.wordBox.label
			DispatchQueue.main.async {
				l?.text = self.currentWord?.uppercased() ?? "?"
			}
		}
	}
	
	var wins: Int = 0 {
		didSet {
			DispatchQueue.main.async {
				self.drawView.winsBox.label.text = "\(self.wins)"
			}
		}
	}
	
	var losses: Int = 0 {
		didSet {
			DispatchQueue.main.async {
				self.drawView.lossesBox.label.text = "\(self.losses)"
			}
		}
	}
	
	var secondsRemaining: Int? = nil {
		didSet {
			DispatchQueue.main.async {
				if let secondsRemaining = self.secondsRemaining {
					self.drawView.timerBox.label.text = "\(secondsRemaining)"
				} else {
					self.drawView.timerBox.label.text = "—"
				}
			}
		}
	}
	
	var drawView: DrawView { return view as! DrawView }
	override func loadView() { view = DrawView(frame: UIScreen.main.bounds) }

	/**********************************************/
	
    override func viewDidLoad() {
        super.viewDidLoad()
		drawView.clearButton.addTarget(nil, action: #selector(clearCanvas), for: .touchUpInside)
		drawView.quitButton.addTarget(GameManager.shared, action: #selector(GameManager.quit), for: .touchUpInside)
		
		GameManager.shared.currentCanvas = drawView.canvas
		currentGuess = nil
		GameManager.shared.delegate = self
		
		if GameManager.shared.singlePlayer {
			currentWord = GameManager.shared.currentWord
		} else {
			currentWord = nil
		}
		
		wins = GameManager.shared.wins
		losses = GameManager.shared.losses
		secondsRemaining = 0
		
		
		
		GameManager.shared.startCountdown()
		
		GyroManager.shared.onFlipDown {}
		GyroManager.shared.onFlipUp {}
		
		if !GameManager.shared.singlePlayer {
			GyroManager.shared.onFlipDown {
				print("GESTURE")
				GameManager.shared.didReceiveGuessGesture()
			}
			GyroManager.shared.listen()
		}
		GyroManager.shared.listen()
    }
	
	override func viewDidDisappear(_ animated: Bool) {
		GameManager.shared.currentCanvas = nil
//		GyroManager.shared.stop()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	@objc func clearCanvas() {
		drawView.canvas.clearDrawing()
		currentGuess = nil
	}
}

extension DrawViewController: GameManagerDelegate {
	func gameStateDidChange(_ gameState: GameState) {
		if case .postDrawing(let win) = gameState {
			// Time's up or model guessed right,
			// freeze the erase button and the canvas.
			print("DrawViewController .postDrawing win=\(win)")
			DispatchQueue.main.async {
				self.drawView.canvasContainer.isUserInteractionEnabled = false
				self.drawView.clearButton.isEnabled = false
			}
			if win {
				wins += 1
			} else {
				losses += 1
			}
			DispatchQueue.main.async {
				Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { timer in
					GameManager.shared.goToNextPage()
				}
			}
		}
	}
	func currentWordDidUpdate(_ currentWord: String?) {}
	
	func modelDidGuess(_ guess: String?) {
		currentGuess = guess
	}
	func countdownDidUpdate(secondsRemaining: Int?) {
		self.secondsRemaining = secondsRemaining
	}
}
