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
	func classify(drawing: UIImage, callback: @escaping (Results)->())
}

class BaseDrawingClassifier: DrawingClassifier {
	static let imageSize: CGSize = CGSize(width: 28, height: 28)
	
	init() {}
	
	internal func prepare(drawing: UIImage) -> UIImage? {
		// Shrink image to 28x28
		guard let resizedDrawing = ImageTools.resize(image: drawing, to: BaseDrawingClassifier.imageSize) else {
			print("Could not resize image.")
			return nil
		}
		
		// Composite image onto white matte, removing transparency (but not alpha channel).
		guard let matteDrawing = ImageTools.convertAlpha(image: resizedDrawing, toMatte: .white) else {
			print("Could not fill in image transparency.")
			return nil
		}
		
		// Convert to 8-bit single-channel grayscale (forcibly removes alpha, which is why we matte first).
		guard let grayscaleDrawing = ImageTools.convertToGrayscale(image: matteDrawing) else {
			print("Could not convert image to grayscale.")
			return nil
		}
		
		guard let invertedDrawing = ImageTools.invert(image: grayscaleDrawing) else {
			print("Could not invert image.")
			return nil
		}
		
		return invertedDrawing
	}
	
	func classify(drawing: UIImage, callback: @escaping (Results)->()) {
		print("classify(drawing:) is a stub in BaseDrawingClassifier.")
	}
}
