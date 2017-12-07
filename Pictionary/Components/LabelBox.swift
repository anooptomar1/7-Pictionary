//
//  LabelBox.swift
//  Pictionary
//
//  Created by Paul Herz on 2017-12-06.
//  Copyright © 2017 Paul Herz. All rights reserved.
//

import UIKit

class LabelBox: UIView {

	var label: UILabel!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .black
		
		layer.cornerRadius = 20
		
		label = {
			let l = UILabel()
			l.translatesAutoresizingMaskIntoConstraints = false
			l.textAlignment = .center
			l.baselineAdjustment = .alignCenters // keep vertical center when text shrinks
			l.font = Fonts.defaultFont.withSize(2.3 * Fonts.em)
			return l
		}()
		addSubview(label)
		
		setNeedsUpdateConstraints()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func updateConstraints() {
		super.updateConstraints()
		let offset: CGFloat = 15
		label.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: offset).isActive = true
		label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 1.5*offset).isActive = true
		label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1.5*offset).isActive = true
		label.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -1*offset).isActive = true
		
		label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		
		widthAnchor.constraint(greaterThanOrEqualTo: heightAnchor, multiplier: 1.1, constant: 0).isActive = true
	}
}
