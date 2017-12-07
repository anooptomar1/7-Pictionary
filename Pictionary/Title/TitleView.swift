//
//  TitleView.swift
//  Pictionary
//
//  Created by Paul Herz on 2017-12-06.
//  Copyright © 2017 Paul Herz. All rights reserved.
//

import UIKit

class TitleView: UIView {

	var gradientBackgroundLayer: CARadialGradientLayer!
	
	var logoView: UIImageView!
	var stackView: UIStackView!
	
	var singlePlayerButton: RoundButton!
	var multiPlayerButton: RoundButton!
	var buttonStack: UIStackView!
	var attributionLabel: UILabel!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		backgroundColor = Colors.background
		
		gradientBackgroundLayer = {
			let l = CARadialGradientLayer()
			l.startColor = Colors.gradientStart.cgColor
			l.endColor = Colors.gradientEnd.cgColor
			l.frame = layer.frame
			return l
		}()
		layer.addSublayer(gradientBackgroundLayer)
		
		logoView = {
			let iv = UIImageView()
			iv.translatesAutoresizingMaskIntoConstraints = false
			iv.image = UIImage(imageLiteralResourceName: "Logo")
			iv.contentMode = .scaleAspectFit
			return iv
		}()
		
		singlePlayerButton = {
			let b = RoundButton()
			b.setTitle("Single Player", for: .normal)
			b.translatesAutoresizingMaskIntoConstraints = false
			return b
		}()
		
		multiPlayerButton = {
			let b = RoundButton()
			b.setTitle("Multi Player", for: .normal)
			b.translatesAutoresizingMaskIntoConstraints = false
			return b
		}()
		
		buttonStack = {
			let s = UIStackView(arrangedSubviews: [
				self.singlePlayerButton,
				self.multiPlayerButton
				])
			s.translatesAutoresizingMaskIntoConstraints = false
			s.axis = .vertical
			s.spacing = 25.0
			return s
		}()
		
		attributionLabel = {
			let l = UILabel()
			l.translatesAutoresizingMaskIntoConstraints = false
			l.font = UIFont(name: "ArialRoundedMTBold", size: UIFont.systemFontSize)
			l.textAlignment = .center
			let now = Date()
			let year = Calendar(identifier: .iso8601).ordinality(of: .year, in: .era, for: now)!
			l.text = "©\(year) By Paul, Jake, and Justin"
			l.textColor = Colors.text
			return l
		}()
		
		stackView = {
			let s = UIStackView(arrangedSubviews: [
				UIView(), // spacer
				self.logoView,
				self.buttonStack,
				attributionLabel
			])
			s.translatesAutoresizingMaskIntoConstraints = false
			s.axis = .vertical
			s.distribution = .equalSpacing
			return s
		}()
		addSubview(stackView)
		
		setNeedsUpdateConstraints()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func updateConstraints() {
		super.updateConstraints()
		
		logoView.widthAnchor.constraint(equalTo: logoView.heightAnchor, multiplier: 1080/693, constant: 0.0).isActive = true
		
		let margins = layoutMarginsGuide
		stackView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
		stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
		stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
		stackView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -20).isActive = true
	}
	
}
