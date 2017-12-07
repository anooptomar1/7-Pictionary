//
//  Colors.swift
//  Pictionary
//
//  Created by Paul Herz on 2017-12-06.
//  Copyright © 2017 Paul Herz. All rights reserved.
//

import UIKit

struct Colors {
	private init() {}
	
	// P3 rgb(255,201,66)
	static let background    = #colorLiteral(red: 1, green: 0.7776710391, blue: 0, alpha: 1)
	
	// P3 rgb(255,244,135)
	static let gradientStart = #colorLiteral(red: 1, green: 0.9550485015, blue: 0.4556424022, alpha: 1)
	
	// P3 rgb(255,162,0)
	static let gradientEnd   = #colorLiteral(red: 1, green: 0.613478601, blue: 0, alpha: 1)
	
	// P3 rgb(96,61,0)
	static let text = #colorLiteral(red: 0.399857223, green: 0.2313200533, blue: 0, alpha: 1)
	
	// P3 rgb(244,228,201)
	static let inverseText = #colorLiteral(red: 0.9701595902, green: 0.89141047, blue: 0.7751421332, alpha: 1)
	
	// P3 rgb(64,223,91)
	static let confirmBackground = #colorLiteral(red: 0, green: 0.889536202, blue: 0.2620587647, alpha: 1)
	
	// P3 rgb(0,109,18)
	static let confirmText = #colorLiteral(red: 0, green: 0.4358231425, blue: 0, alpha: 1)
	
	// P3 rgb(231,70,70)
	static let denyBackground = #colorLiteral(red: 0.9844551682, green: 0.1905710399, blue: 0.2394258678, alpha: 1)
	
	// P3 rgb(114,0,0)
	static let denyText = #colorLiteral(red: 0.491332233, green: 0, blue: 0, alpha: 1)
	
	// P3 rgb(0,122,255)
	static let guessBackground = #colorLiteral(red: 0, green: 0.4877254367, blue: 1, alpha: 1)
}

struct Fonts {
	private init() {}
	
	static let em = UIFont.systemFontSize
	static let defaultFont = UIFont(name: "ArialRoundedMTBold", size: Fonts.em)!
}
