//
//  OperationHistoryViewController.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 05/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit
import CoreData

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

	var dataStoreManager = DataStoreManager()

	var dateTimeLabels: [String] = []
	//var dateTimeLabels: [NSManagedObject] = []
	var specialitiesNameLabels: [String] = []

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
//		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//		let managedContext = appDelegate.persistentContainer.viewContext
//		let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Slot")
//		do {
//			dateTimeLabels = try managedContext.fetch(fetchRequest)
//		} catch let error as NSError {
//			print("Failed to fetch atributes")
//		}
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
    }

	@objc private func refresh(sender: UIRefreshControl) {
//			listener!.getSpecialitiesList { (result) in
//				switch result {
//				case .success(let types):
//					self.datasource = types.specialitiesNames
//				case .failure(_):
//					print("Я хз чи шо, You Know ??? ")
//				}
//			}
			sender.endRefreshing()
			tableView.reloadData()
			finishedLoadingInitialTableCells = false
		}

	func bind(dateTimeLabels: [String], specialitiesNameLabels: [String]) {
		self.dateTimeLabels = dateTimeLabels
		//self.save(dateTimeLabels) // core data
		self.specialitiesNameLabels = specialitiesNameLabels
		self.tableView.reloadData()
	}

//	func save(_ dateTime: [String]) {
//		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//		let managedContext = appDelegate.persistentContainer.viewContext
//		let entity = NSEntityDescription.entity(forEntityName: "Slot", in: managedContext)!
//		let item = NSManagedObject(entity: entity, insertInto: managedContext)
//		item.setValue(dateTime, forKey: "date")
//		do {
//			try managedContext.save()
//			dateTimeLabels.append(item)
//		} catch let error as NSError {
//			print("Failed to save an item", error)
//		}
//	}

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
		return 1 //specializationNames.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		guard let cell = tableView.dequeueReusableCell(withIdentifier: "operationHistory", for: indexPath) as? OperationHistoryCell else { return UITableViewCell() }


		let slot = dataStoreManager.obtainPersonTicket()

		cell.profileImageView.image = UIImage(named: "doctorM")
		// тут пока говно public свойства просто тороплюсь но надо как то перекинуть )
		// public specializationNames, selectTime смотри в coordinator
		// там дичь

		//let item = dateTimeLabels[indexPath.row]
		cell.dateTimeLabel.text = slot.date//selectTime[indexPath.row] //item.value(forKey: "date") as! String  //"28.05.2020 8:20"
			cell.specialitiesNameLabel.text = slot.specialitie//specializationNames[indexPath.row] //"Терапевт"
		cell.addressPolyclicsLabel.text = slot.polyclinic
		return cell
	}
}

extension OperationHistoryViewController : UITableViewDelegate {

	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		var lastInitialDisplayableCell = false

		//change flag as soon as last displayable cell is being loaded (which will mean table has initially loaded)
		if specializationNames.count > 0 && !finishedLoadingInitialTableCells {
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
