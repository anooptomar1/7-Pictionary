//
//  NextWordView.swift
//  Pictionary
//
//  Created by Paul Herz on 2017-12-06.
//  Copyright © 2017 Paul Herz. All rights reserved.
//

import UIKit

class NextWordView: UIView {
	
	var gradientBackgroundLayer: CARadialGradientLayer!
	
	var drawPromptLabel: UILabel!
	var drawItemLabel: UILabel!
	var drawPromptStack: UIStackView!
	
	var acceptCard: UIView!
	var denyCard: UIView!
	var gestureCards: UIStackView!
	
	var quitButton: PushButton!

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
		
		drawPromptLabel = {
			let l = UILabel()
			l.translatesAutoresizingMaskIntoConstraints = false
			l.font = Fonts.defaultFont.withSize(2 * Fonts.em)
			l.textAlignment = .center
			l.text = "Get ready to draw"
			l.textColor = Colors.text
			return l
		}()
		
		drawItemLabel = {
			let l = UILabel()
			l.translatesAutoresizingMaskIntoConstraints = false
			l.font = Fonts.defaultFont.withSize(3 * Fonts.em)
			l.textAlignment = .center
			l.text = "OCTOPUS"
			l.textColor = Colors.text
			l.lineBreakMode = .byWordWrapping
			l.numberOfLines = 0
			return l
		}()
		
		drawPromptStack = {
			let s = UIStackView(arrangedSubviews: [
				UIView(), // spacer
				drawPromptLabel,
				drawItemLabel,
				UIView() // spacer
			])
			s.translatesAutoresizingMaskIntoConstraints = false
			s.axis = .vertical
			s.distribution = .equalSpacing
			s.spacing = 20
			return s
		}()
		addSubview(drawPromptStack)
		
		acceptCard = makeCard(
			image: UIImage(imageLiteralResourceName: "flip-forward"),
			title: "OK!",
			subtitle: "(flip towards you)",
			backgroundColor: Colors.confirmBackground,
			textColor: Colors.confirmText
		)
		
		denyCard = makeCard(
			image: UIImage(imageLiteralResourceName: "flip-back"),
			title: "Pass...",
			subtitle: "(flip away)",
			backgroundColor: Colors.denyBackground,
			textColor: Colors.denyText
		)
		
		gestureCards = {
			let s = UIStackView(arrangedSubviews: [
				acceptCard,
				denyCard
			])
			s.translatesAutoresizingMaskIntoConstraints = false
			s.distribution = .fillEqually
			s.axis = .horizontal
			
			return s
		}()
		addSubview(gestureCards)
		
		quitButton = {
			let b = PushButton()
			b.translatesAutoresizingMaskIntoConstraints = false
			b.setImage(UIImage(imageLiteralResourceName: "Quit"), for: .normal)
			return b
		}()
		addSubview(quitButton)
		
		setNeedsUpdateConstraints()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func makeCard(image: UIImage?, title: String, subtitle: String, backgroundColor bg: UIColor, textColor fg: UIColor) -> UIView {
		let v = UIView()
		v.backgroundColor = bg
		v.translatesAutoresizingMaskIntoConstraints = false
		
		let icon = UIImageView(image: image)
		icon.translatesAutoresizingMaskIntoConstraints = false
		icon.contentMode = .center
		
		let titleLabel: UILabel = {
			let l = UILabel()
			l.font = Fonts.defaultFont.withSize(2 * Fonts.em)
			l.textColor = fg
			l.textAlignment = .center
			l.translatesAutoresizingMaskIntoConstraints = false
			l.text = title
			return l
		}()
		
		let subtitleLabel: UILabel = {
			let l = UILabel()
			l.font = Fonts.defaultFont.withSize(1.25 * Fonts.em)
			l.textColor = fg
			l.textAlignment = .center
			l.translatesAutoresizingMaskIntoConstraints = false
			l.text = subtitle
			return l
		}()
		
		let wordStack = UIStackView(arrangedSubviews: [
			titleLabel,
			subtitleLabel,
			UIView()
		])
		wordStack.translatesAutoresizingMaskIntoConstraints = false
		wordStack.axis = .vertical
		wordStack.distribution = .equalSpacing
		
		let stack = UIStackView(arrangedSubviews: [
			icon,
			wordStack
		])
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.distribution = .fill
		stack.alignment = .center
		stack.spacing = 25
		v.addSubview(stack)
		
		icon.widthAnchor.constraint(equalTo: stack.widthAnchor, multiplier: 1.0, constant: 0).isActive = true
		icon.heightAnchor.constraint(equalTo: icon.widthAnchor).isActive = true
		
		stack.topAnchor.constraint(greaterThanOrEqualTo: v.topAnchor).isActive = true
		stack.leadingAnchor.constraint(equalTo: v.leadingAnchor).isActive = true
		stack.trailingAnchor.constraint(equalTo: v.trailingAnchor).isActive = true
		stack.bottomAnchor.constraint(lessThanOrEqualTo: v.bottomAnchor).isActive = true
		stack.centerYAnchor.constraint(equalTo: v.centerYAnchor).isActive = true
		
		return v
	}
	
	func flashCard(_ card: UIView) {
		let background = card.backgroundColor
		UIView.animate(withDuration: 0.3, animations: {
			card.backgroundColor = .white
		}) { complete in
			UIView.animate(withDuration: 0.3) {
				card.backgroundColor = background
			}
		}
	}
	
	override func updateConstraints() {
		super.updateConstraints()
		
		let margins = layoutMarginsGuide
		
		quitButton.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
		quitButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		
		drawPromptStack.topAnchor.constraint(equalTo: quitButton.bottomAnchor).isActive = true
		drawPromptStack.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
		drawPromptStack.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
		drawPromptStack.bottomAnchor.constraint(equalTo: gestureCards.topAnchor, constant: -10).isActive = true
		
		gestureCards.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5, constant: 0).isActive = true
		gestureCards.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		gestureCards.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		gestureCards.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
	}
}
