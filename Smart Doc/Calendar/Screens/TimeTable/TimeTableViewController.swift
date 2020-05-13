//
//  TimeTableViewController.swift
//  Smart Doc
//
//  Created by 17790204 on 01/03/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

/// Интерфейс взаимодействия с вью-контроллером экрана TimeTableViewController.
protocol TimeTableControllable {}

// TO DO : viewcontroller - все через протокол CalendarViewControllable
// убрать UIViewController

/// Интерфейс взаимодействия с презентером экрана TimeTableViewController.
protocol TimeTablePresentableListener {

	/// Данные загрузились
	///
	/// - Parameter viewController: текущий вью контроллер
	func didLoad(_ viewController: UIViewController)

	/// Информирует листенер о нажатии кнопки назад.
	///
	/// - Parameter viewController: Вью-контроллера экрана DoctorsSpecialities.
	func didPressBack(_ viewController: UIViewController)

	/// Пользователь выбрал удобное время и записался на прием
	/// - Parameters:
	///   - slotID: id выбранного талона
	///   - firstName: Имя пользователя
	///   - birthday: Дата рождения пользователя
	///   - phoneNumber: Номер телефона
	///   - email: Электронная почта
	///   - polis: Номер полиса
	func createAppointment(slotID: String,
						   firstName: String,
						   birthday: String,
						   phoneNumber: String,
						   email: String,
						   polis: String)
}

/// Расписание
class TimeTableViewController: UIViewController {

	/// Талоны
	var datasourse: TicketModel?

	private let descriptionLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.boldSystemFont(ofSize: 25)
		label.textColor = .gray
		label.text = "Выберите свободное время:"
		label.backgroundColor = .white
		return label
	}()

	private lazy var collectionView: UICollectionView = {
		let collectionViewLayout = UICollectionViewFlowLayout()
		collectionViewLayout.scrollDirection = .vertical
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.showsVerticalScrollIndicator = false
		collectionView.backgroundColor = .white
		collectionView.clipsToBounds = true // false
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.register(TimeTableCollectionViewCell.self,
								forCellWithReuseIdentifier: "CollectionViewCell")
		return collectionView
	}()

	private var listener: TimeTablePresentableListener?

	init(listener: TimeTablePresentableListener) {
		super.init(nibName: nil, bundle: nil)
		self.listener = listener
	}

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		view.addSubview(descriptionLabel)
		view.addSubview(collectionView)
		setupView()
	}

	private func setupView() {
		NSLayoutConstraint.activate([

			descriptionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 35),
			descriptionLabel.heightAnchor.constraint(equalToConstant: 45),
			descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor),
			descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),

			collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
		])
	}
}

extension TimeTableViewController: UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return datasourse?.row.count ?? 0
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! TimeTableCollectionViewCell

		cell.titleLabel.text = datasourse?.row[indexPath.row].TIME_SHOW

		if datasourse?.row[indexPath.row].STATE == 1 { cell.cellView.backgroundColor = .red }
		print(datasourse?.row[indexPath.row].TIME_SHOW)

		return cell
	}
}

extension TimeTableViewController: UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

		let firstName = UserSettings.userModel.name
		let birthday = UserSettings.userModel.birthdate
		let phoneNumber = UserSettings.userModel.telephone
		let email = UserSettings.userModel.email
		let polis = UserSettings.userModel.polis

		let slotID = datasourse?.row[indexPath.row].id ?? "0000"

		if datasourse?.row[indexPath.row].STATE == 1 {
			print("Данное время занято, Выберите пожалуйста другое время для записи к врачу")
		} else {
			listener!.createAppointment(slotID: slotID,
			firstName: firstName,
			birthday: birthday,
			phoneNumber: phoneNumber,
			email: email,
			polis: polis)
		}
	}

	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: collectionView.frame.width / 3.5,
					  height: collectionView.frame.width / 4)
	}

	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 15
	}

	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 15
	}
}

