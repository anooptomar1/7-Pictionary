//
//  SettingsView.swift
//  Pictionary
//
//  Created by Paul Herz on 2017-12-08.
//  Copyright © 2017 Paul Herz. All rights reserved.
//

import UIKit

class SettingsView: UIView {
	
	var gradientBackgroundLayer: CALayer!
	var confirmButton: RoundButton!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		backgroundColor = Colors.background
		
		gradientBackgroundLayer = {
			let l = CARadialGradientLayer()
			l.startColor = Colors.gradientStart.cgColor
			l.endColor = Colors.gradientEnd.cgColor
			l.frame = layer.frame
			return l
		}()
		layer.addSublayer(gradientBackgroundLayer)
		
//		testLabel = {
//			let l = UILabel()
//			l.translatesAutoresizingMaskIntoConstraints = false
//			l.font = Fonts.defaultFont.withSize(1.6 * Fonts.em)
//			l.textAlignment = .center
//			l.text = "Your group is battling against the computer. If you guess right, flick the phone towards you.\n\nPass me to the next drawer."
//			l.numberOfLines = 0
//			l.lineBreakMode = .byWordWrapping
//			return l
//		}()
//		addSubview(testLabel)
		
		confirmButton = {
			let r = RoundButton()
			r.setTitle("Done", for: .normal)
			r.translatesAutoresizingMaskIntoConstraints = false
			return r
		}()
		addSubview(confirmButton)
		
		setNeedsUpdateConstraints()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func updateConstraints() {
		super.updateConstraints()
		
		let margins = layoutMarginsGuide
		
		confirmButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
		confirmButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
		confirmButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -20).isActive = true
	}
}

