//
//  SettingsViewController.swift
//  Pictionary
//
//  Created by Paul Herz on 2017-12-08.
//  Copyright © 2017 Paul Herz. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
	
	// Underlying view override
	var settingsView: SettingsView { return view as! SettingsView }
	override func loadView() { view = SettingsView(frame: UIScreen.main.bounds) }
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		settingsView.confirmButton.addTarget(self, action: #selector(didPressConfirm), for: .touchUpInside)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	@objc func didPressConfirm() {
		dismiss(animated: true, completion: nil)
	}
}

