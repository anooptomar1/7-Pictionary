//
//  PassViewController.swift
//  Pictionary
//
//  Created by Paul Herz on 2017-12-08.
//  Copyright © 2017 Paul Herz. All rights reserved.
//

import UIKit

class PassViewController: UIViewController {
	
	// Underlying view override
	var passView: PassView { return view as! PassView }
	override func loadView() { view = PassView(frame: UIScreen.main.bounds) }
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		GyroManager.shared.stop()
		
		passView.quitButton.addTarget(GameManager.shared, action: #selector(GameManager.quit), for: .touchUpInside)
		passView.confirmButton.addTarget(GameManager.shared, action: #selector(GameManager.goToNextPage), for: .touchUpInside)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}
