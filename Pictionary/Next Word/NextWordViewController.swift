//
//  NextWordViewController.swift
//  Pictionary
//
//  Created by Paul Herz on 2017-12-06.
//  Copyright © 2017 Paul Herz. All rights reserved.
//

import UIKit

class NextWordViewController: UIViewController {
	
	var nextWordView: NextWordView {
		return view as! NextWordView
	}
	
	lazy var gyroManager = GyroManager()
	
	override func loadView() {
		view = NextWordView(frame: UIScreen.main.bounds)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
        
		gyroManager.onFlipDown(didAcceptWord)
		gyroManager.onFlipUp(didDenyWord)
		gyroManager.listen()
    }
	
	override func viewDidDisappear(_ animated: Bool) {
		gyroManager.stop()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func didAcceptWord() {
		self.nextWordView.flashCard(self.nextWordView.acceptCard)
	}
	
	func didDenyWord() {
		self.nextWordView.flashCard(self.nextWordView.denyCard)
	}
}
