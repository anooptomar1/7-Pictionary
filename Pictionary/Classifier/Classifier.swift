//
//  Classifier.swift
//  Pictionary
//
//  Created by Paul Herz on 2017-12-06.
//  Copyright © 2017 Paul Herz. All rights reserved.
//

import UIKit

protocol DrawingClassifier {
	static func classify(drawing: UIImage)
}

class BaseDrawingClassifier {
	static let imageSize: (Int, Int) = (28, 28)
	
	static private func prepare(drawing: UIImage) -> UIImage? {
		guard let grayscaleDrawing = ImageTools.convertToGrayscale(image: drawing) else {
			print("Could not convert image to grayscale.")
			return nil
		}
		guard let matteDrawing = ImageTools.convertAlpha(image: grayscaleDrawing, toMatte: .white) else {
			print("Could not fill in image transparency.")
			return nil
		}
		
	}
}
