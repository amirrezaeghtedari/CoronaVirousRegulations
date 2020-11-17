//
//  TableViewSection.swift
//  CoronaVirousRegulations
//
//  Created by Amirreza Eghtedari on 8/20/1399 AP.
//

import UIKit

class RegulationSectionView: UIView {
	
	private let label = UILabel()
	private let line = UIView()
	
	init() {
		super.init(frame: .zero)
		
		configView()
		configLabel()
		configLine()
	}
	
	private func configView() {
		
		self.backgroundColor = .systemBackground
	}
	
	private func configLabel() {
		
		label.textColor = .label
		label.font		= UIFont.preferredFont(forTextStyle: .title1)
		
		label.translatesAutoresizingMaskIntoConstraints = false
		addSubview(label)
		
		let margin = CGFloat(8)
		
		NSLayoutConstraint.activate([
			
			label.topAnchor.constraint(equalTo: self.topAnchor, constant: margin),
			label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
			label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
			label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -margin)
		])
	}
	
	private func configLine() {
		
		line.backgroundColor = .systemGray
		
		line.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(line)
	
		NSLayoutConstraint.activate([
		
			line.widthAnchor.constraint(equalTo: self.widthAnchor),
			line.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			line.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3),
			line.heightAnchor.constraint(equalToConstant: 1)
		])
	}
	
	required init?(coder: NSCoder) {
		
		fatalError("init(coder:) has not been implemented")
	}
	
	func set(title: String, lineColor: UIColor) {
		
		label.text = title
		line.backgroundColor = lineColor
	}
}
