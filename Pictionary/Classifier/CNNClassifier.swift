//
//  CNNClassifier.swift
//  Pictionary
//
//  Created by Paul Herz on 2017-12-07.
//  Copyright © 2017 Paul Herz. All rights reserved.
//

import UIKit
import CoreML
import Vision

class CNNClassifier: BaseDrawingClassifier {
	
	lazy var model = try? VNCoreMLModel(for: CNN().model)
	
	override init() {
		super.init()
	}
	override func classify(drawing: UIImage, callback: @escaping (Results)->()) {
		guard let preparedImage = prepare(drawing: drawing) else {
			print("Could not prepare image.")
			return
		}
		guard let cgImage = preparedImage.cgImage else {
			print("Could not get underlying cgImage")
			return
		}
		guard let model = model else {
			print("No model!")
			return
		}
		let request = VNCoreMLRequest(model: model) { request, error in
			guard let results = request.results as? [VNClassificationObservation] else {
				print("unexpected result type from VNCoreMLRequest")
				return
			}
			let resultsTuples = results.map { ($0.identifier, Double($0.confidence)) }
			let resultsDict = Dictionary.init(uniqueKeysWithValues: resultsTuples)
			callback(resultsDict)
		}
		request.imageCropAndScaleOption = .scaleFit
		
		let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
		DispatchQueue.global(qos: .userInteractive).async {
			do {
				try handler.perform([request])
			} catch {
				print("VNImageRequestHandler.perform(_:) error: \(error)")
			}
		}
	}
}
