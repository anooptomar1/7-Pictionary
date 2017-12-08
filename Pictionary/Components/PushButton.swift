//
//  PushButton.swift
//  Pictionary
//
//  Created by Paul Herz on 2017-12-07.
//  Copyright © 2017 Paul Herz. All rights reserved.
//

import UIKit

class PushButton: UIButton {
	
	override var isEnabled: Bool {
		didSet {
			alpha = isEnabled ? 1 : 0.6
		}
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesBegan(touches, with: event)
		guard isEnabled else { return }
		UIView.animate(withDuration: 0.1) {
			self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		}
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesEnded(touches, with: event)
		guard isEnabled else { return }
		UIView.animate(withDuration: 0.1) {
			self.transform = CGAffineTransform(scaleX: 1, y: 1)
		}
	}
	
	override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
		let generousBounds = CGRect(x: bounds.minX - 20, y: bounds.minY - 20, width: bounds.width + 40, height: bounds.height + 40)
		if generousBounds.contains(point) { return self }
		return nil
	}
}
