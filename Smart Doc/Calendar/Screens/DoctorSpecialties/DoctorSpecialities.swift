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
}

class DoctorSpecialities: UIViewController  {

	let datasource = [
	"Стоматолог", // A417276AC757742CE0530100007F6A68
	"Терапевт", // 7F7DA9355EAAF96FE0530100007F0F8B
	"Хирург", // 7FA60C0CEEE364F3E0530100007F82C1
	"Невролог",
	"Офтальмолог",
	"Оториноларинголог",
	"Педиатр"
	]

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

	private lazy var tableView : UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(DoctorSpecialitiesCell.self, forCellReuseIdentifier: "cellId")
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
		//cell.backgroundColor = UIColor.white
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
		listener?.didOpenCalendar(Resource_ID: selectDoctor)
	}
}

