//
//  ViewController.swift
//  CoronaVirousRegulations
//
//  Created by Amirreza Eghtedari on 8/17/1399 AP.
//

import UIKit

class RegulationsViewController: UIViewController {
	
	let interactor: RegulationsInteractorInterface
	
	let tableView = UITableView()
	
	var dataSource: UITableViewDiffableDataSource<RegulationSectionViewModel, RegulationViewModel>!
	
	let headerView		= UIView()
	let circleView 		= CircleView()
	let levelsStackView	= UIStackView()
	
	let alwaysLocationPermissionNotificationName: Notification.Name
	
	init(interactor: RegulationsInteractorInterface, alwaysLocationPermissionNotificationName: Notification.Name) {
		
		self.interactor = interactor
		self.alwaysLocationPermissionNotificationName = alwaysLocationPermissionNotificationName
		
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		configDataSource()
		configViewController()
		configHeaderView()
		conficCircleView()
		configLavelsStackView()
		configTableView()
		
		observeAppDidBecomeActiveNotification()
		observeAppDidBecomeInactiveNotification()
		observeAlwaysLocationPermissionNotification()
		
		circleView.showLoading()
		interactor.getGeneralInfo()
		interactor.getIncidentsInfo()
	}
	
	func observeAlwaysLocationPermissionNotification() {
		
		NotificationCenter.default.addObserver(self, selector: #selector(alwayLocationPermissionDidReceive), name: alwaysLocationPermissionNotificationName, object: nil)
	}
	
	@objc
	func alwayLocationPermissionDidReceive() {
		
		getLocalNotificationPermission()
	}
	
	func observeAppDidBecomeInactiveNotification() {
		
		NotificationCenter.default.addObserver(self, selector: #selector(saveCurrentThreatColor), name: UIApplication.didBecomeActiveNotification, object: nil)
	}
	
	@objc
	func saveCurrentThreatColor() {
		
		interactor.saveCurrentThreatColor()
	}
	
	func getLocalNotificationPermission() {
		
		UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert]) {
			(allowed, err) in
		}
	}
	
	func observeAppDidBecomeActiveNotification() {
		
		NotificationCenter.default.addObserver(self, selector: #selector(appDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
	}
	
	@objc
	func appDidBecomeActive() {
		
		tableView.reloadData()
	}
	
	func configDataSource() {
		
		dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { (tableView, indexPath, regulationViewModel) -> UITableViewCell? in
			
			guard let cell = tableView.dequeueReusableCell(withIdentifier: RgulationTableViewCell.reuseIdentifier) as? RgulationTableViewCell else {
				
				return UITableViewCell()
			}
			
			cell.set(description: regulationViewModel.description, image: UIImage(named: regulationViewModel.imageId))
			
			return cell
		})
		
		dataSource.defaultRowAnimation = .fade
	}
	
	func configViewController() {
		
		view.backgroundColor = .systemBackground
	}
	
	func configHeaderView() {
		
		headerView.translatesAutoresizingMaskIntoConstraints = false
		headerView.backgroundColor 	= .systemBackground
		tableView.tableHeaderView 	= headerView
		
		NSLayoutConstraint.activate([
			headerView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
			headerView.widthAnchor.constraint(equalTo: tableView.widthAnchor),
			headerView.topAnchor.constraint(equalTo: tableView.topAnchor)
		])
	}
	
	func conficCircleView() {
		
		circleView.delegate = self
		
		circleView.translatesAutoresizingMaskIntoConstraints = false
		headerView.addSubview(circleView)
		
		NSLayoutConstraint.activate([
			
			circleView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 30),
			circleView.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.6),
			circleView.heightAnchor.constraint(equalTo: circleView.widthAnchor),
			circleView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor)
		])
	}
	
	func configLavelsStackView() {
		
		levelsStackView.axis 			= .horizontal
		levelsStackView.distribution 	= .fillEqually
		levelsStackView.alignment		= .fill
		levelsStackView.spacing			= 10
		
		levelsStackView.translatesAutoresizingMaskIntoConstraints = false
		headerView.addSubview(levelsStackView)
		
		let hMargin = CGFloat(0)
		NSLayoutConstraint.activate([
			
			levelsStackView.topAnchor.constraint(equalTo: circleView.bottomAnchor, constant: 30),
			levelsStackView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: hMargin),
			levelsStackView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -hMargin),
			levelsStackView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -16)
		])
	}
	
	func configTableView() {
		
		tableView.separatorStyle 				= .none
		tableView.tableHeaderView 				= headerView
		tableView.showsVerticalScrollIndicator 	= false
		tableView.delegate 						= self
		
		tableView.register(RgulationTableViewCell.self, forCellReuseIdentifier: RgulationTableViewCell.reuseIdentifier)
		
		tableView.translatesAutoresizingMaskIntoConstraints 	= false
		view.addSubview(tableView)
		
		let hMargin = CGFloat(16)
		let vMargin	= CGFloat(16)
		
		NSLayoutConstraint.activate([
			
			tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: vMargin),
			tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: hMargin),
			tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -hMargin),
			tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
		])
	}
}

extension RegulationsViewController: RegulationsPresenterDelegate {
	
	func presenterDidStartGetRegulations(_ presenter: RegulationsPresenterInterface) {
		
		//It can be used to show the start of each new incidents checking process, but I think it is not necessary here.
	}
	
	func presenterDidGet(_ presenter: RegulationsPresenterInterface, generalInfo: GeneralInfoViewModel) {
		
		for threatLevel in generalInfo.threatLevels {
			
			let textColor: UIColor
			
			switch threatLevel.textColor {
			
			case .dark:
				textColor = .black
			
			case .light:
				textColor = .white
			}
			
			let viewColor: UIColor
			
			switch threatLevel.levelColor {
			
			case .green:
				viewColor = .systemGreen
			
			case .yellow:
				viewColor = .systemYellow
			
			case .red:
				viewColor = .systemRed
			
			case .gray:
				viewColor = .systemGray
			
			case .darkRed:
				viewColor = UIColor(named: "darkRed") ?? .systemGray
			}
			
			let levelView = LevelView()
			levelView.set(text: threatLevel.description, textColor: textColor, viewColor: viewColor)
			levelsStackView.addArrangedSubview(levelView)
		}
		
		DispatchQueue.main.async {
			
			var snapshot = NSDiffableDataSourceSnapshot<RegulationSectionViewModel, RegulationViewModel>()
			snapshot.appendSections([generalInfo.generalSection])
			snapshot.appendItems(generalInfo.generalSection.regulations)
			
			self.dataSource.apply(snapshot)
		}
	}
	
	func presenterDidGet(_ presenter: RegulationsPresenterInterface, incidentsInfo: Result<IncidentsViewModel, Error>) {
		
		DispatchQueue.main.async { [weak self] in
			
			guard let self = self else { return }
			
			self.circleView.dismissLoading()
			
			switch incidentsInfo {
			
			case .failure(_):
				let failed = NSLocalizedString("failed", comment: "")
				self.circleView.set(incidentsCount: "!", hint: failed, incidentColor: UIColor.black, circleColor: .systemGray)
				
			case .success(let incidentsViewModel):
				self.handleIncidentsViewModelSuccess(incidentsViewModel: incidentsViewModel)
			}
		}
	}
	
	private func handleIncidentsViewModelSuccess(incidentsViewModel: IncidentsViewModel) {
		
		let incidentTextColor: 	UIColor
		
		switch incidentsViewModel.incidentsTextColor {
		
		case .dark:
			incidentTextColor = .black
			
		case .light:
			incidentTextColor = .white
		}
		
		let circleColor: UIColor
		
		switch incidentsViewModel.incidentsBackColor {
		
		case .green:
			circleColor = .systemGreen
			
		case .yellow:
			circleColor = .systemYellow
			
		case .red:
			circleColor = .systemRed
			
		case .gray:
			circleColor = .systemGray
			
		case .darkRed:
			circleColor = UIColor(named: "darkRed") ?? .systemGray
		}
		
		let hint = NSLocalizedString("No. of Incidence in 100,000", comment: "")
		circleView.set(incidentsCount: incidentsViewModel.incidentsNo, hint: hint, incidentColor: incidentTextColor, circleColor: circleColor)
		
		var snapshot = NSDiffableDataSourceSnapshot<RegulationSectionViewModel, RegulationViewModel>()
		
		for section in incidentsViewModel.regulationSections {
			snapshot.appendSections([section])
			snapshot.appendItems(section.regulations)
		}
		
		self.dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
	}
}

extension RegulationsViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		
		let section = dataSource.snapshot().sectionIdentifiers[section]
		let title = section.title
		let sectionView = RegulationSectionView()
		
		let lineColor: UIColor
		
		switch section.color {
		
		case .green:
			lineColor = .systemGreen
		
		case .yellow:
			lineColor = .systemYellow
		
		case .red:
			lineColor = .systemRed
		
		case .gray:
			lineColor = .label
		
		case .darkRed:
			lineColor = UIColor(named: "darkRed") ?? .systemGray
		}
		
		sectionView.set(title: title, lineColor: lineColor)
		
		return sectionView
	}
	
	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		
		if scrollView.contentOffset.y < 0 {
			
			circleView.showLoading()
			interactor.getIncidentsInfo()
		}
	}
}

extension RegulationsViewController: CircleViewDelegate {
	
	func circleViewDidTap(circleView: CircleView) {
		
		circleView.showLoading()
		interactor.getIncidentsInfo()
	}
	
}

