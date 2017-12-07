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
	
	var gyroManager: GyroManager!
	
	override func loadView() {
		view = NextWordView(frame: UIScreen.main.bounds)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		gyroManager = GyroManager()
		gyroManager.onFlipDown {
			self.nextWordView.flashCard(self.nextWordView.acceptCard)
		}
		gyroManager.onFlipUp {
			self.nextWordView.flashCard(self.nextWordView.denyCard)
		}
		gyroManager.listen()
    }
	
	override func viewDidDisappear(_ animated: Bool) {
		gyroManager.stop()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
}
