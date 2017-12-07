//
//  Classifier.swift
//  Pictionary
//
//  Created by Paul Herz on 2017-12-06.
//  Copyright © 2017 Paul Herz. All rights reserved.
//

import UIKit
import CoreML

protocol DrawingClassifier {
	typealias Results = [String: Double]
	func classify(drawing: UIImage, callback: @escaping (String?,Results?)->())
}

class BaseDrawingClassifier: DrawingClassifier {
	static let imageSize: CGSize = CGSize(width: 28, height: 28)
	init() {}
	
	internal func prepare(drawing: UIImage) -> MLMultiArray? {
		
		var d = ImageTools.resize(image: drawing, to: BaseDrawingClassifier.imageSize)
		d = ImageTools.convertAlpha(image: d!, toMatte: .white)
		d = ImageTools.invert(image: d!)
		
		return ImageTools.convertToMLMultiArray(image: d!)
	}
	
	func classify(drawing: UIImage, callback: @escaping (String?,Results?)->()) {
		print("classify(drawing:) is a stub in BaseDrawingClassifier.")
		callback(nil,nil)
	}
}
