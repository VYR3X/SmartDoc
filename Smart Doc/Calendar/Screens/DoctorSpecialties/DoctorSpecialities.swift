//
//  DoctorSpecialities.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 30/03/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

class DoctorSpecialities: UIViewController  {

	private lazy var tableView : UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(DoctorSpecialitiesCell.self, forCellReuseIdentifier: "cellId")
		return tableView
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		view.addSubview(tableView)
		setupTableView()
	}

	func setupTableView (){
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
			tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
			tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
			tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
			])
	}

}

extension DoctorSpecialities : UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! DoctorSpecialitiesCell
		//cell.backgroundColor = UIColor.white
		cell.dayLabel.text = "Стоматолог"
		return cell
	}
}

extension DoctorSpecialities : UITableViewDelegate {

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

		///  вынести отображение вью черех координатор
		let viewController = CalendarViewController()
		present(viewController, animated: true, completion: nil)
	}
}

