//
//  CARadialGradientLayer.swift
//  Pictionary
//
//  Created by Paul Herz on 2017-12-05.
//  Copyright © 2017 Paul Herz. All rights reserved.
//

import UIKit

class CARadialGradientLayer: CALayer {
	
	var startColor: CGColor = UIColor.clear.cgColor {
		didSet {
			self.setNeedsDisplay()
		}
	}
	var endColor: CGColor = UIColor.clear.cgColor {
		didSet {
			self.setNeedsDisplay()
		}
	}
	
	override init() {
		super.init()
		self.setNeedsDisplay()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.setNeedsDisplay()
	}
	
	override func draw(in ctx: CGContext) {
		
		let locations: [CGFloat] = [0.0, 1.0]
		
		guard
			let startComponents = startColor.components,
			let endComponents = endColor.components
		else {
			print("Warning: could not get components for gradient colors")
			return
		}
		let colorCodes = startComponents + endComponents
		let colorSpace = CGColorSpaceCreateDeviceRGB()
		
		let gradient = CGGradient(colorSpace: colorSpace, colorComponents: colorCodes, locations: locations, count: locations.count)
		
		let center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
		let radius = min(self.bounds.size.width, self.bounds.size.height)
		
		ctx.drawRadialGradient(gradient!, startCenter: center, startRadius: 0, endCenter: center, endRadius: radius, options: .drawsAfterEndLocation)
	}
}
