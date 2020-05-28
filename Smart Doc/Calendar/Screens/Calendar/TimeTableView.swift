//
//  TimeTableView.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 26/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

final class TimeTableView: UIView {

	var datasource = ["8:00", "8:20", "8:40", "9:00", "9.20",
					  "9.40", "10:00", "10.20", "10.40", "11:00"];

	private let refreshControl: UIRefreshControl = {
		let refreshControl = UIRefreshControl()
		refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
		refreshControl.backgroundColor = .clear
		refreshControl.tintColor = .white
		return refreshControl
	}()

	private lazy var collectionView: UICollectionView = {
		let collectionViewLayout = UICollectionViewFlowLayout()
		collectionViewLayout.scrollDirection = .vertical
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.showsVerticalScrollIndicator = false
		collectionView.backgroundColor = UIColor(red: 125/255, green: 0/255, blue: 235/255, alpha: 1)
		collectionView.clipsToBounds = true
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.register(TimeTableCollectionViewCell.self,
								forCellWithReuseIdentifier: "CollectionViewCell")
		collectionView.refreshControl = refreshControl
		return collectionView
	}()


	private var listener: TimeTablePresentableListener?

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = UIColor.clear
		setupView()
	}

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	@objc private func refresh(sender: UIRefreshControl) {
		// TO: DO - добавить выгрузку данных
		//listener.getData
		sender.endRefreshing()
	}

	private func setupView() {

		addSubviews(collectionView)

		NSLayoutConstraint.activate([

			collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
			collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
			collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
			collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25)
		])
	}

	private func showAlertButtonTapped() {

		// create the alert
		let alert = UIAlertController(title: "", message: "Запись прошла успешно", preferredStyle: UIAlertController.Style.alert)

		// add an action (button)
		alert.addAction(UIAlertAction(title: "ОК", style: UIAlertAction.Style.default, handler: nil))

		// show the alert
		//self.present(alert, animated: true, completion: nil)
	}
}

extension TimeTableView: UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return datasource.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! TimeTableCollectionViewCell

		//			cell.titleLabel.text = datasourse?.row[indexPath.row].TIME_SHOW
		//
		//			if datasourse?.row[indexPath.row].STATE == 1 { cell.cellView.backgroundColor = .red }
		//			print(datasourse?.row[indexPath.row].TIME_SHOW)

		cell.titleLabel.text = datasource[indexPath.row]
		return cell
	}
}

extension TimeTableView: UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

		//			let firstName = UserSettings.userModel.name
		//			let birthday = UserSettings.userModel.birthdate
		//			let phoneNumber = UserSettings.userModel.telephone
		//			let email = UserSettings.userModel.email
		//			let polis = UserSettings.userModel.polis
		//
		//			let slotID = datasourse?.row[indexPath.row].id ?? "0000"
		//
		//			if datasourse?.row[indexPath.row].STATE == 1 {
		//				print("Данное время занято, Выберите пожалуйста другое время для записи к врачу")
		//			} else {
		//				listener!.createAppointment(slotID: slotID,
		//				firstName: firstName,
		//				birthday: birthday,
		//				phoneNumber: phoneNumber,
		//				email: email,
		//				polis: polis)
		//				showAlertButtonTapped()
		//			}
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
