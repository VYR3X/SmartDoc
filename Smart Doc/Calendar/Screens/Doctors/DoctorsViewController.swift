//
//  DoctorsViewController.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 01/03/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

/// Интерфейс взаимодействия с вью-контроллером экрана DoctorsViewController.
protocol DoctorsViewControllable {}

// TO DO : viewcontroller - все через протокол CalendarViewControllable
// убрать UIViewController

/// Интерфейс взаимодействия с презентером экрана DoctorsViewController.
protocol DoctorsPresentableListener {

	/// Данные загрузились
	///
	/// - Parameter viewController: текущий вью контроллер
	func didLoad(_ viewController: UIViewController)

	/// Информирует листенер о нажатии кнопки назад.
	///
	/// - Parameter viewController: Вью-контроллера экрана TransferToAnotherPerson.
	func didPressBack(_ viewController: UIViewController)

	/// Информирует листенер о готовности записаться к врачу
	func didPressReadyToMeetDoctor()
}

/// Экран со списком имен врачей
class DoctorsViewController: UIViewController  {

	let datasource = [
	"Смирнова М. М.",
	"Петрова С. В.",
	"Иванова Т. И.",
	"Кошкина Е. В.",
	"Сидорова Е. И.",
	"Козловская Е. М.",
	"Цукерберг М. Р."
	]

	private var finishedLoadingInitialTableCells = false

	private var listener: DoctorsPresentableListener?

	init(listener: DoctorsPresentableListener) {
		super.init(nibName: nil, bundle: nil)
		self.listener = listener
	}

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

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
		refreshControl.backgroundColor = .clear
		return refreshControl
	}()

	private lazy var tableView : UITableView = {
		let tableView = UITableView()
		tableView.backgroundColor = .clear
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(DoctorTableViewCell.self, forCellReuseIdentifier: "cellId")
		tableView.refreshControl = refreshControl
		return tableView
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubviews(descriptionLabel, tableView)
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
		// TO: DO - добавить выгрузку данных
		//listener.getData
		sender.endRefreshing()
		tableView.reloadData()
		finishedLoadingInitialTableCells = false
	}

	func setupTableView () {
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

extension DoctorsViewController : UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return datasource.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! DoctorTableViewCell

		cell.dayLabel.text = datasource[indexPath.row]
		cell.descrioption.text = "Терапевт"
		cell.picture.image = UIImage(named: "doctorM")
		return cell
	}
}

extension DoctorsViewController : UITableViewDelegate {

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
			cell.transform = CGAffineTransform(translationX: 0, y: 100/2)
			cell.alpha = 0

			UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row), options: [.curveEaseInOut], animations: {
				cell.transform = CGAffineTransform(translationX: 0, y: 0)
				cell.alpha = 1
			}, completion: nil)
		}
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 150
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
		listener!.didPressReadyToMeetDoctor()
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
