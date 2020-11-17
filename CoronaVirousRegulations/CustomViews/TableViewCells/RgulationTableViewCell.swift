//
//  CountryTableViewCell.swift
//  RoundTableAppsAssignment
//
//  Created by Amirreza Eghtedari on 7/28/1399 AP.
//

import UIKit

class RgulationTableViewCell: UITableViewCell {

	static var reuseIdentifier: String {
		
		String(describing: self)
	}
	
	let backView			= UIView()
	let regulationLabel 	= UILabel()
	let regulationImageView	= UIImageView()
	
	let hMargin 	= CGFloat(8)
	let vMargin		= CGFloat(8)
	
    override func awakeFromNib() {
        
		super.awakeFromNib()
        
		configBackView()
		configTableViewCell()
		configRegulationLabel()
		configRegulationImageView()
    }

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		configBackView()
		configTableViewCell()
		configRegulationLabel()
		configRegulationImageView()
	}
	
	required init?(coder: NSCoder) {
		
		fatalError("init(coder:) has not been implemented")
	}
	
	func configBackView() {
		
		backView.backgroundColor 	= .secondarySystemBackground
		backView.layer.cornerRadius = 10
		
		backView.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(backView)
		
		let margin = CGFloat(5)
		
		NSLayoutConstraint.activate([
		
			backView.topAnchor.constraint(equalTo: self.topAnchor, constant: margin),
			backView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
			backView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
			backView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -margin)
		])
	}
	
	func configTableViewCell() {
		
		self.selectionStyle = .none
	}
	
	func configRegulationLabel() {
		
		regulationLabel.font			= .preferredFont(forTextStyle: .body)
		regulationLabel.textColor		= .label
		regulationLabel.numberOfLines 	= 0
		
		regulationLabel.setContentHuggingPriority(UILayoutPriority(20), for: .horizontal)
		regulationLabel.setContentCompressionResistancePriority(UILayoutPriority(20), for: .horizontal)
		regulationLabel.translatesAutoresizingMaskIntoConstraints = false
		
		regulationLabel.translatesAutoresizingMaskIntoConstraints = false
		backView.addSubview(regulationLabel)
		
		let topConstraint 		= regulationLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: vMargin)
		let trailingConstraint 	= regulationLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -hMargin)
		let bottomConstraint 	= regulationLabel.bottomAnchor.constraint(lessThanOrEqualTo: backView.bottomAnchor, constant: -vMargin)
		bottomConstraint.priority = UILayoutPriority(999)
		
		NSLayoutConstraint.activate([topConstraint, trailingConstraint, bottomConstraint])
	}
	
	func configRegulationImageView() {
		
		let imageSize	= CGFloat(75)
		regulationImageView.layer.cornerRadius = 10
		regulationImageView.clipsToBounds = true
		
		regulationImageView.translatesAutoresizingMaskIntoConstraints = false
		backView.addSubview(regulationImageView)
		
		let topAnchor 		= regulationImageView.topAnchor.constraint(equalTo: backView.topAnchor, constant: vMargin)
		let leadingAnchor 	= regulationImageView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: hMargin)
		let trailingAnchor 	= regulationImageView.trailingAnchor.constraint(equalTo: regulationLabel.leadingAnchor, constant: -hMargin)
		let widthAnchor 	= regulationImageView.widthAnchor.constraint(equalToConstant: imageSize)
		let heightAnchor 	= regulationImageView.heightAnchor.constraint(equalToConstant: imageSize)
		let bottomAnchor	= regulationImageView.bottomAnchor.constraint(lessThanOrEqualTo: backView.bottomAnchor, constant: -vMargin)
		
		NSLayoutConstraint.activate([topAnchor, leadingAnchor, trailingAnchor, widthAnchor, heightAnchor, bottomAnchor])
	}
	
	func set(description: String, image: UIImage?) {
		
		self.regulationLabel.text 		= description
		self.regulationImageView.image 	= image
	}
	
    override func setSelected(_ selected: Bool, animated: Bool) {
        
		super.setSelected(selected, animated: animated)
    }

}

