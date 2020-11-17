//
//  CircleView.swift
//  CoronaVirousRegulations
//
//  Created by Amirreza Eghtedari on 8/19/1399 AP.
//

import UIKit

class CircleView: UIView {
	
	weak var delegate: CircleViewDelegate?
	
	let incidentsLabel 	= UILabel()
	let hintLabel		= UILabel()
	let loadingView		= UIActivityIndicatorView(frame: .zero)
	
	init() {
		
		super.init(frame: .zero)
		
		configView()
		configIncidentsLabel()
		configHintLabel()
		configLoadingView()
		configGesture()
	}
	
	required init?(coder: NSCoder) {
		
		fatalError("init(coder:) has not been implemented")
	}
	
	func configGesture() {
		
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
		addGestureRecognizer(tapGesture)
	}
	
	@objc
	func didTap() {
		
		delegate?.circleViewDidTap(circleView: self)
	}
	
	func configLoadingView() {
		
		loadingView.layer.isOpaque  = false
		loadingView.hidesWhenStopped = false
		loadingView.color			= .white
		loadingView.backgroundColor	= .systemGray
		loadingView.clipsToBounds 	= true
		loadingView.alpha 			= 0
		loadingView.style 			= .large
		
		loadingView.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(loadingView)
		
		NSLayoutConstraint.activate([
		
			loadingView.topAnchor.constraint(equalTo: self.topAnchor),
			loadingView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			loadingView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			loadingView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
		])
	}
	
	private func configView() {
		
		backgroundColor 			= .systemGray
		layer.shadowColor			= UIColor.systemGray.cgColor
		layer.shadowOpacity			= 1
		layer.shadowRadius			= 15
		layer.shadowOffset.width	= 0
		layer.shadowOffset.height	= 0
	}
	
	private func configIncidentsLabel() {
		
		incidentsLabel.font 	= UIFont.systemFont(ofSize: 50, weight: .bold)
		incidentsLabel.text		= ""
		
		incidentsLabel.translatesAutoresizingMaskIntoConstraints = false
		addSubview(incidentsLabel)
		
		NSLayoutConstraint.activate([
			
			incidentsLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -30),
			incidentsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
		])
	}
	
	private func configHintLabel() {
		
		hintLabel.font		= UIFont.systemFont(ofSize: 20, weight: .regular)
		hintLabel.text		= NSLocalizedString("No. of Incidence in 100,000", comment: "")
		hintLabel.numberOfLines	= 3
		hintLabel.textAlignment	= .center
		
		hintLabel.translatesAutoresizingMaskIntoConstraints = false
		addSubview(hintLabel)
		
		NSLayoutConstraint.activate([
		
			hintLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 40),
			hintLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			hintLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40)
		])
	}
	
	func set(incidentsCount: String, hint: String, incidentColor: UIColor, circleColor: UIColor) {
		
		incidentsLabel.text 		= incidentsCount
		incidentsLabel.textColor	= incidentColor
		hintLabel.text				= hint
		hintLabel.textColor			= incidentColor
		backgroundColor				= circleColor
		layer.shadowColor			= circleColor.cgColor
	}
	
	func showLoading() {
		
		loadingView.startAnimating()
		UIView.animate(withDuration: 0.25) {
			
			self.loadingView.alpha = 0.9
		}
	}
	
	func dismissLoading() {
		
		loadingView.stopAnimating()
		
		UIView.animate(withDuration: 0.25) {
			self.loadingView.alpha = 0
		}
	}
	
	override func layoutSubviews() {
		
		super.layoutSubviews()
		
		layer.cornerRadius = frame.width / 2
		
		loadingView.layer.cornerRadius = frame.width / 2
	}
}
