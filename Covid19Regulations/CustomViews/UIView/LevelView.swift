//
//  LevelView.swift
//  CoronaVirousRegulations
//
//  Created by Amirreza Eghtedari on 8/19/1399 AP.
//

import UIKit

class LevelView: UIView {
	
	let label 	= UILabel()
	
	let hMargin		= CGFloat(10)
	let vMargin		= CGFloat(5)
	
	init() {
		
		super.init(frame: .zero)
		
		configView()
		configLabel()
	}
	
	required init?(coder: NSCoder) {
		
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configView() {
		
		backgroundColor = .systemGray
	}
	
	private func configLabel() {
		
		label.numberOfLines	= 2
		label.font			= UIFont.systemFont(ofSize: 11, weight: .regular)
		label.text			= NSLocalizedString("Less than", comment: "") + " 35"
		label.textAlignment	= .center
		
		label.translatesAutoresizingMaskIntoConstraints = false
		addSubview(label)
		
		NSLayoutConstraint.activate([
		
			label.topAnchor.constraint(equalTo: topAnchor, constant: vMargin),
			label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: hMargin),
			label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -hMargin),
			label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -vMargin)
		])
	}
	
	func set(text: String, textColor: UIColor, viewColor: UIColor) {
		
		label.text 		= text
		label.textColor	= textColor
		backgroundColor	= viewColor
	}
	
	override func layoutSubviews() {
		
		super.layoutSubviews()
		layer.cornerRadius = frame.height / 2
	}
}
