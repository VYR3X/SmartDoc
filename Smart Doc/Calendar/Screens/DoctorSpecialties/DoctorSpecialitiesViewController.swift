//
//  DoctorSpecialities.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 30/03/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

/// Интерфейс взаимодействия с презентером экрана TransferToAnotherPerson.
protocol DoctorSpecialitiesListener {

	/// Данные загрузились
	///
	/// - Parameter viewController: текущий вью контроллер
	func didLoad(_ viewController: UIViewController)

	/// Информирует листенер о нажатии кнопки назад.
	///
	/// - Parameter viewController: Вью-контроллера экрана TransferToAnotherPerson.
	func didPressBack(_ viewController: UIViewController)

	/// Информирует листенер о переходе на экран календарь
	/// - Parameter Resource_ID: id выбранной специализации врача
	func didOpenCalendar(Resource_ID: String)

	/// Получить спискок специальностей
	/// - Parameter completion: комплишн блок
	func getSpecialitiesList(completion: @escaping (Result<SpecialitiesViewModel, Error>) -> Void)
}

/// Экран со списком всех доступных специальностей врачей
final class DoctorSpecialitiesViewController: UIViewController {

//	var datasource = [
//	"Стоматолог", // A417276AC757742CE0530100007F6A68
//	"Терапевт", // 7F7DA9355EAAF96FE0530100007F0F8B
//	"Хирург", // 7FA60C0CEEE364F3E0530100007F82C1
//	"Невролог",
//	"Офтальмолог",
//	"Оториноларинголог",
//	"Педиатр"
//	]

	private struct Constants {
		static let cellHeight: CGFloat = 84
	}

	var datasource = ["Терапевт", "Хирург", "Стоматолог"];

	// стоматологи пока не записывают )
	let Resource_ID = [ "A417276AC757742CE0530100007F6A68", "7F7DA9355EAAF96FE0530100007F0F8B", "7FA60C0CEEE364F3E0530100007F82C1" ]

	/// Переменная для анимации отображения ячейки
	private var finishedLoadingInitialTableCells = false

	private let descriptionLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.boldSystemFont(ofSize: 25)
		label.textColor = .white
		label.text = "Выберите врача из списка:"
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
		tableView.backgroundColor = .clear
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.delegate = self
		tableView.dataSource = self
		tableView.separatorStyle = .none
		tableView.register(DoctorSpecialitiesCell.self, forCellReuseIdentifier: "cellId")
		//tableView.refreshControl = refreshControl
		tableView.addSubview(refreshControl)
		return tableView
	}()

	/// Листенер для экрана DoctorSpecialities
	private var listener: DoctorSpecialitiesListener?

	init(listener: DoctorSpecialitiesListener) {
		super.init(nibName: nil, bundle: nil)
		self.listener = listener
	}

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubviews(descriptionLabel, tableView)
		self.title = "Запись"
		navigationController?.navigationBar.barTintColor = Colors.mainColor
		navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
		//tabBarController?.tabBar.barTintColor = Colors.mainColor
		setupTableView()
		setGradient()
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

	@objc private func refresh(sender: UIRefreshControl) {
//		var state = 0
		listener!.getSpecialitiesList { (result) in
			switch result {
			case .success(let types):
				self.datasource = types.specialitiesNames
			case .failure(_):
				print("Я хз чи шо, You Know ??? ")
			}
//			state = 1
		}
		sender.endRefreshing()
		tableView.reloadData()
		finishedLoadingInitialTableCells = false
//		if (state == 1 ) {
//			sender.endRefreshing()
//			self.tableView.reloadData()
//		} else {
//			print("ХЗ")
//		}
	}

	private func setupTableView () {
		NSLayoutConstraint.activate([

			descriptionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 45),
			descriptionLabel.heightAnchor.constraint(equalToConstant: 45),
			descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor),
			descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),

			tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
			tableView.leftAnchor.constraint(equalTo: view.leftAnchor)
			])
	}

}

// MARK: - UITableViewDataSource

extension DoctorSpecialitiesViewController: UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return datasource.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! DoctorSpecialitiesCell
		cell.specialitiesNameLabel.text = datasource[indexPath.row]
		return cell
	}
}

// MARK: - UITableViewDelegate

extension DoctorSpecialitiesViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		var lastInitialDisplayableCell = false

		//change flag as soon as last displayable cell is being loaded (which will mean table has initially loaded)
		if datasource.count > 0 && !finishedLoadingInitialTableCells {
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

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		let selectDoctor = Resource_ID[indexPath.row];
		print("Выбранная специализация врача: \(selectDoctor) - Resourse_ID")
		listener?.didOpenCalendar(Resource_ID: selectDoctor)
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
