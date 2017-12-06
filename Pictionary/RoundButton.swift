//
//  RoundButton.swift
//  Pictionary
//
//  Created by Paul Herz on 2017-12-05.
//  Copyright © 2017 Paul Herz. All rights reserved.
//

import UIKit

class RoundButton: UIButton {
	
	var borderLayer = CALayer()
	var backgroundLayer = CALayer()
	
	let cornerRadius: CGFloat = 20.0
	let bottomOffset: CGFloat = 7
	
	let lightColor: CGColor = UIColor(red: 0.0, green: 155/255, blue: 1.0, alpha: 1.0).cgColor
	let darkColor: CGColor = UIColor(red: 0.0, green: 128/255, blue: 206/255, alpha: 1.0).cgColor
	
	private var isActive: Bool = false {
		didSet {
			backgroundLayer.backgroundColor = isActive ? darkColor : lightColor
			if isActive {
				contentEdgeInsets = UIEdgeInsets(top: 15+bottomOffset, left: 15, bottom: 15-bottomOffset, right: 15)
			} else {
				contentEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
			}
			UIView.animate(withDuration: 0.15) {
				self.layoutSubviews()
			}
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupAppearance()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupAppearance()
	}
	
	private func setupAppearance() {
		guard let titleLabel = titleLabel else { return }
		titleLabel.font = UIFont(name: "ArialRoundedMTBold", size: 30.0)
		
		backgroundLayer.cornerRadius = self.cornerRadius
		borderLayer.cornerRadius = self.cornerRadius
		borderLayer.backgroundColor = darkColor
		
		self.layer.insertSublayer(backgroundLayer, at: 0)
		self.layer.insertSublayer(borderLayer, at: 0)
		
		isActive = false
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		let activeOffset: CGFloat = isActive ? bottomOffset : 0
		backgroundLayer.frame = CGRect(origin: CGPoint(x: 0, y: activeOffset), size: layer.bounds.size)
		borderLayer.frame = CGRect(origin: CGPoint(x: 0, y: bottomOffset), size: layer.bounds.size)
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesBegan(touches, with: event)
		isActive = true
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesEnded(touches, with: event)
		isActive = false
	}
}
