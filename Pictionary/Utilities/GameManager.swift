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
	static let guessThreshold = 0.5
	static let shared = GameManager()
	
	lazy var classifier: DrawingClassifier = CNNClassifier()
	var delegate: GameManagerDelegate? = nil
	
	var currentCanvas: TouchDrawView? = nil {
		didSet {
			if currentCanvas != nil {
				startPollingCanvas()
			} else {
				stopPollingCanvas()
			}
		}
	}
	
	var canvasPollingTimer: Timer? = nil
	
	private init() {
		print("GameManager awake.")
	}
	
	private func startPollingCanvas() {
//		print("startPollingCanvas")
		
		canvasPollingTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
			guard let canvas = self.currentCanvas else { return }
			guard !canvas.exportStack().isEmpty else { return }
			
			self.classifier.classify(drawing: canvas.exportDrawing()) { results in
				// Get the most confident prediction out of the Category,Confidence dictionary
				let maxResult = results.reduce(into: (key:"",value:0.0)) { (result, element) in
					if element.value > result.value {
						result = element
					}
				}
				print(maxResult)
				if maxResult.value > GameManager.guessThreshold {
					self.delegate?.modelDidGuess(maxResult.key)
				} else {
					self.delegate?.modelDidGuess(nil)
				}
			}
		}
	}
	
	private func stopPollingCanvas() {
//		print("stopPollingCanvas")
		canvasPollingTimer?.invalidate()
		canvasPollingTimer = nil
	}
}
