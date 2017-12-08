//
//  RandomForestClassifier.swift
//  Pictionary
//
//  Created by Paul Herz on 2017-12-08.
//  Copyright © 2017 Paul Herz. All rights reserved.
//

import UIKit
import CoreML
import Vision

class RandomForestClassifier: BaseDrawingClassifier {
	
	lazy var model = RandomForest()
	
	override init() {
		super.init()
	}
	override func classify(drawing: UIImage, callback: @escaping (String?,Results?)->()) {
		guard let array = prepare(drawing: drawing) else {
			print("Could not prepare image.")
			callback(nil,nil)
			return
		}
		DispatchQueue.global(qos: .userInitiated).async {
			do {
				let output = try self.model.prediction(drawing: array)
				
				let classLabel = Words.shared.list[Int(output.catagory)]
				let probabilities = output.classProbability.map { (arg) -> (String, Double) in
					let (k, v) = arg
					return (Words.shared.list[Int(k)], v)
				}
				let probabilitiesDict = Dictionary(uniqueKeysWithValues: probabilities)
				callback(classLabel, probabilitiesDict)
			} catch {
				print("RandomForestClassifier error: \(error)")
				callback(nil,nil)
			}
		}
	}
}
