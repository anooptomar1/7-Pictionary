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
	
	var drawView: DrawView { return view as! DrawView }
	override func loadView() { view = DrawView(frame: UIScreen.main.bounds) }

    override func viewDidLoad() {
        super.viewDidLoad()
		drawView.clearButton.addTarget(nil, action: #selector(clearCanvas), for: .touchUpInside)
		
		GameManager.shared.currentCanvas = drawView.canvas
		
		currentGuess = nil
		GameManager.shared.delegate = self
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
	func modelDidGuess(_ guess: String?) {
		currentGuess = guess
	}
}
