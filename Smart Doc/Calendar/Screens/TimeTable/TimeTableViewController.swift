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
	func createAppointment()
}

/// Расписание
class TimeTableViewController: UIViewController {

	let datasource = [
	["9.00", "10.00", "11.00", "12.00", "13.00", "14.00", "15.00", "16.00"],
	["9.15", "10.15", "11.15", "12.15", "13.15", "14.15", "15.15", "16.15"],
	["9.30", "10.30", "11.30", "12.30", "13.30", "14.30", "15.30", "16.30"],
	["9.45", "10.45", "11.45", "12.45", "13.45", "14.45", "15.45", "16.45"]
	]

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
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.backgroundColor = .white
		collectionView.clipsToBounds = false
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.register(TimeTableCollectionViewCell.self,
								forCellWithReuseIdentifier: "CollectionViewCell")
		return collectionView
	}()

	private let button: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.layer.cornerRadius = 15
		button.backgroundColor = .purple
		return button
	}()

	private let buttonLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .white
		label.text = "Записаться на прием"
		label.font = UIFont.boldSystemFont(ofSize: 25)
		return label
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
		view.addSubview(button)
		button.addSubview(buttonLabel)
		setupView()
	}

	private func setupView() {
		NSLayoutConstraint.activate([

			descriptionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 35),
			descriptionLabel.heightAnchor.constraint(equalToConstant: 45),
			descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor),
			descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),

			collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -350),
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

			button.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 25),
			button.heightAnchor.constraint(equalToConstant: 45),
			button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25),
			button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),

			buttonLabel.heightAnchor.constraint(equalToConstant: 30),
			buttonLabel.centerXAnchor.constraint(equalTo: button.centerXAnchor),
			buttonLabel.centerYAnchor.constraint(equalTo: button.centerYAnchor)


		])
	}
}

extension TimeTableViewController: UICollectionViewDataSource {

	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 8
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 4 //datasource.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! TimeTableCollectionViewCell

		cell.titleLabel.text = datasource[indexPath.row][indexPath.section]
	//	cell.backgroundColor = UIColor(red: 144/255, green: 238/255, blue: 144/255, alpha: 1)
		//cell.layer.cornerRadius = 20
		return cell
	}
}

extension TimeTableViewController: UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

		listener!.createAppointment()
		//guard let session = sessions?[safe: indexPath.row] else { return }

		//selectedIndex = indexPath.row
		//delegate?.didSelectSessionWith(id: session.id)
	}

	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 90,
					  height: 45)
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

