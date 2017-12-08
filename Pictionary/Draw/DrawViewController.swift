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
			drawView.winsBox.label.text = "\(wins)"
		}
	}
	
	var losses: Int = 0 {
		didSet {
			drawView.lossesBox.label.text = "\(losses)"
		}
	}
	
	var secondsRemaining: Int? = nil {
		didSet {
			if let secondsRemaining = secondsRemaining {
				drawView.timerBox.label.text = "\(secondsRemaining)"
			} else {
				drawView.timerBox.label.text = "—"
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
		
		wins = 0
		losses = 0
		secondsRemaining = 0
		
		GameManager.shared.startCountdown()
    }
	
	override func viewDidDisappear(_ animated: Bool) {
		GameManager.shared.currentCanvas = nil
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
	func gameStateDidChange(_ gameState: GameState) {}
	func currentWordDidUpdate(_ currentWord: String?) {}
	
	func modelDidGuess(_ guess: String?) {
		currentGuess = guess
	}
	func countdownDidUpdate(secondsRemaining: Int?) {
		self.secondsRemaining = secondsRemaining
	}
}
