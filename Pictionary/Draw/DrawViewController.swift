//
//  DrawViewController.swift
//  Pictionary
//
//  Created by Paul Herz on 2017-12-06.
//  Copyright © 2017 Paul Herz. All rights reserved.
//

import UIKit

class DrawViewController: UIViewController {
	
	var drawView: DrawView { return view as! DrawView }
	override func loadView() { view = DrawView(frame: UIScreen.main.bounds) }

    override func viewDidLoad() {
        super.viewDidLoad()
		drawView.clearButton.addTarget(nil, action: #selector(clearCanvas), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	@objc func clearCanvas() {
		drawView.canvas.clearDrawing()
	}

}
