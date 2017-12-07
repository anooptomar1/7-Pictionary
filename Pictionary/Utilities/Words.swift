//
//  Words.swift
//  Pictionary
//
//  Created by Paul Herz on 2017-12-07.
//  Copyright © 2017 Paul Herz. All rights reserved.
//

import Foundation

func random(_ r: ClosedRange<Int>) -> Int {
	let span = abs(r.upperBound-r.lowerBound)
	return Int(arc4random_uniform(UInt32(span)))+r.lowerBound
}

class Words {
	private(set) static var shared = Words()
	let list: [String]
	
	private init() {
		let path = Bundle.main.path(forResource: "categories", ofType: "txt")!
		let categoryString = try! String(contentsOfFile: path)
		list = categoryString.split(separator: "\n").map { String($0) }
	}
	
	func random() -> String {
		return list[Pictionary.random(0...list.count-1)]
	}
}
