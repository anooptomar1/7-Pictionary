//
//  ViewController.swift
//  Pictionary
//
//  Created by Paul Herz on 2017-12-05.
//  Copyright © 2017 Paul Herz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	var testLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		testLabel = {
			let l = UILabel()
			l.translatesAutoresizingMaskIntoConstraints = false
			l.text = "Hello World"
			return l
		}()
		view.addSubview(testLabel)
		updateViewConstraints()
	}
	
	override func updateViewConstraints() {
		super.updateViewConstraints()
		testLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		testLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

