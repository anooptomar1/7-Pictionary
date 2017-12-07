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
	
	lazy var model = CNN()
	
	override init() {
		super.init()
	}
	override func classify(drawing: UIImage, callback: @escaping (String?,Results?)->()) {
		guard let array = prepare(drawing: drawing) else {
			print("Could not prepare image.")
			callback(nil,nil)
			return
		}
		DispatchQueue.global(qos: .userInteractive).async {
			do {
				print(array)
				let output = try self.model.prediction(drawing: array)
				print(output.classLabel, output.output1[output.classLabel]!)
				callback(output.classLabel, output.output1)
			} catch {
				print("CNNClassifier error: \(error)")
				print(" • \(error.localizedDescription)")
				callback(nil,nil)
			}
		}
	}
}
