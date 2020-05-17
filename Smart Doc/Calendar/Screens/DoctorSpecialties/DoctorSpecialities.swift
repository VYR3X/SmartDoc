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

	func getDoctorsModel()

	func getviewModel(completion: @escaping (Result<SpecialitiesViewModel, Error>) -> Void)
}

class DoctorSpecialities: UIViewController  {

//	var datasource = [
//	"Стоматолог", // A417276AC757742CE0530100007F6A68
//	"Терапевт", // 7F7DA9355EAAF96FE0530100007F0F8B
//	"Хирург", // 7FA60C0CEEE364F3E0530100007F82C1
//	"Невролог",
//	"Офтальмолог",
//	"Оториноларинголог",
//	"Педиатр"
//	]

	var datasource = ["Терапевт", "Хирург"];

	// стоматологи пока не записывают )
	let Resource_ID = [ "A417276AC757742CE0530100007F6A68", "7F7DA9355EAAF96FE0530100007F0F8B", "7FA60C0CEEE364F3E0530100007F82C1" ]

	private let descriptionLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.boldSystemFont(ofSize: 25)
		label.textColor = .gray
		label.text = "Выберите врача из списка:"
		label.backgroundColor = .white
		return label
	}()

	let refreshControl: UIRefreshControl = {
		let refreshControl = UIRefreshControl()
		refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
		refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
		refreshControl.backgroundColor = .clear // если не будет фона то анимация будет залезать на таблицу
		return refreshControl
	}()

	private lazy var tableView : UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.delegate = self
		tableView.dataSource = self
		tableView.separatorStyle = .none
//		tableView.allowsSelection = false
//		tableView.scrollIndicatorInsets.bottom = 64
		tableView.register(DoctorSpecialitiesCell.self, forCellReuseIdentifier: "cellId")
		//tableView.refreshControl = refreshControl
		tableView.addSubview(refreshControl)
		return tableView
	}()

	var listener: DoctorSpecialitiesListener?

	init(listener: DoctorSpecialitiesListener) {
		super.init(nibName: nil, bundle: nil)
		self.listener = listener
	}

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .white
		view.addSubview(descriptionLabel)
		view.addSubview(tableView)
		setupTableView()
	}

	@objc private func refresh(sender: UIRefreshControl) {
//		var state = 0
		listener!.getviewModel { (result) in
			switch result {
			case .success(let types):
				self.datasource = types.specialitiesNames
			case .failure(_):
				print("Я хз чи шо, You Know ??? ")
			}
//			state = 1
		}
		sender.endRefreshing()
		self.tableView.reloadData()
//		if (state == 1 ) {
//			sender.endRefreshing()
//			self.tableView.reloadData()
//		} else {
//			print("ХЗ")
//		}
	}

	func setupTableView (){
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

extension DoctorSpecialities : UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return datasource.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! DoctorSpecialitiesCell
		cell.dayLabel.text = datasource[indexPath.row]
		return cell
	}
}

extension DoctorSpecialities : UITableViewDelegate {

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		let selectDoctor = Resource_ID[indexPath.row];
		print("Выбранная специализация врача: \(selectDoctor) - Resourse_ID")
		listener?.didOpenCalendar(Resource_ID: selectDoctor)
		tableView.deselectRow(at: indexPath, animated: true)
	}
}

