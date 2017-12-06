//
//  TitleViewController.swift
//  Pictionary
//
//  Created by Paul Herz on 2017-12-05.
//  Copyright © 2017 Paul Herz. All rights reserved.
//

import UIKit

class TitleViewController: UIViewController {
	
	var gradientBackgroundLayer: CARadialGradientLayer!
	
	var logoView: UIImageView!
	var stackView: UIStackView!
	
	var singlePlayerButton: RoundButton!
	var multiPlayerButton: RoundButton!
	var buttonStack: UIStackView!
	var attributionLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = UIColor(red: 255/255, green: 201/255, blue: 66/255, alpha: 1.0)
		
		gradientBackgroundLayer = {
			let l = CARadialGradientLayer()
			l.startColor = UIColor(red: 255/255, green: 244/255, blue: 135/255, alpha: 1.0).cgColor
			l.endColor = UIColor(red: 255/255, green: 162/255, blue: 0/255, alpha: 1.0).cgColor
			l.frame = view.layer.frame
			return l
		}()
		view.layer.addSublayer(gradientBackgroundLayer)
		
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
			l.font = UIFont(name: "ArialRoundedMTBold", size: UIFont.systemFontSize)
			l.textAlignment = .center
			let now = Date()
			let year = Calendar(identifier: .iso8601).ordinality(of: .year, in: .era, for: now)!
			l.text = "©\(year) By Paul, Jake, and Justin"
			l.textColor = UIColor(red: 96/255, green: 61/255, blue: 0/255, alpha: 1.0)
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
		view.addSubview(stackView)
		
		updateViewConstraints()
	}
	
	override func updateViewConstraints() {
		super.updateViewConstraints()
		
		logoView.widthAnchor.constraint(equalTo: logoView.heightAnchor, multiplier: 1080/693, constant: 0.0).isActive = true
//
//		logoView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
//		logoView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
//
		let margins = view.layoutMarginsGuide
		stackView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
		stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
		stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
		stackView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -20).isActive = true
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

