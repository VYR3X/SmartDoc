//
//  OperationHistoryViewController.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 05/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit
import CoreData

var dataStoreManager = DataStoreManager()

/// Интерфейс взаимодействия с вью-контроллером экрана OperationHistory.
protocol OperationHistoryViewControllable: UIViewController {

	func bind(dateTimeLabels: [String], specialitiesNameLabels: [String])

}

protocol OperationHistoryPresentableListener {

	func didLoad(_ viewController: OperationHistoryViewControllable, resourceID: String)
}

/// Экран история записей к врачу 
final class OperationHistoryViewController: UIViewController, OperationHistoryViewControllable {

	private struct Constants {
		static let cellHeight: CGFloat = 150
	}

	private var tickets: [Ticket] = []
	//var slots = [NSManagedObject]()

    private let listener: OperationHistoryPresentableListener

	/// Переменная для анимации отображения ячейки
	private var finishedLoadingInitialTableCells = false

	// MARK: UI

	private let descriptionLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.boldSystemFont(ofSize: 25)
		label.textColor = .white1
		label.text = "История приемов:"
		label.backgroundColor = .clear
		return label
	}()

	private let refreshControl: UIRefreshControl = {
		let refreshControl = UIRefreshControl()
		refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
		//refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
		refreshControl.backgroundColor = .clear // если не будет фона то анимация будет залезать на таблицу
		refreshControl.tintColor = .white
		return refreshControl
	}()

	private lazy var tableView : UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(OperationHistoryCell.self, forCellReuseIdentifier: "operationHistory")
		tableView.backgroundColor = .clear
		tableView.refreshControl = refreshControl
		return tableView
	}()

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
	}

    init(listener: OperationHistoryPresentableListener) {
        self.listener = listener
        super.init(nibName: nil, bundle: nil)

    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
		listener.didLoad(self, resourceID: "7F7DA9355EAAF96FE0530100007F0F8B")
		view.backgroundColor = UIColor(red: 125/255, green: 0/255, blue: 235/255, alpha: 1)
		view.addSubview(descriptionLabel)
		view.addSubview(tableView)
		setupTableView()
		setGradient()
		tickets = dataStoreManager.fetchTicketsFromCoreData()
    }

	@objc private func refresh(sender: UIRefreshControl) {
			sender.endRefreshing()
			tickets = dataStoreManager.fetchTicketsFromCoreData()
			tableView.reloadData()
			finishedLoadingInitialTableCells = false
		}

	func bind(dateTimeLabels: [String], specialitiesNameLabels: [String]) {
		self.tableView.reloadData()
	}

	private func setGradient() {
		let gradient: CAGradientLayer = CAGradientLayer()

		let leftColor = Colors.mainColor
		let rightColor = UIColor.purple

		gradient.colors = [leftColor.cgColor, rightColor.cgColor]
		gradient.locations = [0.0 , 1.0]
		gradient.startPoint = CGPoint(x: 0.4, y: 0.6)
		gradient.endPoint = CGPoint(x: 1.0, y: 0.0)
		gradient.frame = CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: view.frame.size.height)

		view.layer.insertSublayer(gradient, at: 0)
	}

	private func setupTableView (){
		NSLayoutConstraint.activate([

			descriptionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
			descriptionLabel.heightAnchor.constraint(equalToConstant: 45),
			descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor),
			descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),

			tableView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
			tableView.leftAnchor.constraint(equalTo: view.leftAnchor)
			])
	}
}

extension OperationHistoryViewController : UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tickets.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		guard let cell = tableView.dequeueReusableCell(withIdentifier: "operationHistory", for: indexPath) as? OperationHistoryCell else { return UITableViewCell() }

		cell.profileImageView.image = UIImage(named: "doctorM")
		cell.dateTimeLabel.text = tickets[indexPath.row].date
		cell.specialitiesNameLabel.text = tickets[indexPath.row].specialitie
		cell.addressPolyclicsLabel.text = tickets[indexPath.row].polyclinic

		return cell
	}

	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
	  if editingStyle == .delete {
		print("Deleted")
		tickets.remove(at: indexPath.row)
		self.tableView.deleteRows(at: [indexPath], with: .automatic)
		dataStoreManager.deleteData()
	  }
	}
}

extension OperationHistoryViewController : UITableViewDelegate {

	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		var lastInitialDisplayableCell = false

		//change flag as soon as last displayable cell is being loaded (which will mean table has initially loaded)
		if tickets.count > 0 && !finishedLoadingInitialTableCells {
			if let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows,
				let lastIndexPath = indexPathsForVisibleRows.last, lastIndexPath.row == indexPath.row {
				lastInitialDisplayableCell = true
			}
		}

		if !finishedLoadingInitialTableCells {

			if lastInitialDisplayableCell {
				finishedLoadingInitialTableCells = true
			}

			//animates the cell as it is being displayed for the first time
			cell.transform = CGAffineTransform(translationX: 0, y: Constants.cellHeight / 2)
			cell.alpha = 0

			UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row), options: [.curveEaseInOut], animations: {
				cell.transform = CGAffineTransform(translationX: 0, y: 0)
				cell.alpha = 1
			}, completion: nil)
		}
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return Constants.cellHeight
	}
}
