//
//  RandomClassifier.swift
//  Pictionary
//
//  Created by Paul Herz on 2017-12-07.
//  Copyright © 2017 Paul Herz. All rights reserved.
//

import UIKit

class RandomClassifier: DrawingClassifier {
	
	init() {}
	
	func classify(drawing: UIImage, callback: @escaping (String?,DrawingClassifier.Results?) -> ()) {
		let randomWord = Words.shared.random()
		callback(randomWord, [
			randomWord: 1.0
		])
	}
}
