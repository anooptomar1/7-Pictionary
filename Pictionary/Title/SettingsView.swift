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
	var networkSwitch: UISwitch!
	var switchStack: UIStackView!
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
		
		networkSwitch = {
			let sw = UISwitch()
			sw.translatesAutoresizingMaskIntoConstraints = false
			return sw
		}()
		
		switchStack = {
			let l1 = UILabel()
			l1.translatesAutoresizingMaskIntoConstraints = false
			l1.textAlignment = .center
			l1.font = Fonts.defaultFont.withSize(1.25 * Fonts.em)
			l1.textColor = Colors.text
			l1.text = "CNN"
			
			let l2 = UILabel()
			l2.translatesAutoresizingMaskIntoConstraints = false
			l2.textAlignment = .center
			l2.font = Fonts.defaultFont.withSize(1.25 * Fonts.em)
			l2.textColor = Colors.text
			l2.text = "RF"
			let s = UIStackView(arrangedSubviews: [
				UIView(), l1, networkSwitch, l2, UIView()
			])
			s.translatesAutoresizingMaskIntoConstraints = false
			s.axis = .horizontal
			s.distribution = .equalCentering
			return s
		}()
		addSubview(switchStack)
		
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
		
		switchStack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		switchStack.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
		switchStack.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
		
		confirmButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
		confirmButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
		confirmButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -20).isActive = true
	}
}

