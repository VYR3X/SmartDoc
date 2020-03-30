//
//  DoctorsViewController.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 01/03/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

class DoctorsViewController: UIViewController  {

	let datasource = [
	"Смирнова Мария Михайловна",
	"Петрова Светлана Владимировна",
	"Иванова Татьяна Игоревна",
	"Кошкина Елена Владимировна",
	"Сидорова Екатерина Ивановна",
	"Козловская Елизавета Михайловна",
	"Цукерберг Марк Ростиславович"
	]

	private lazy var tableView : UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(DayCellTableViewCell.self, forCellReuseIdentifier: "cellId")
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

extension DoctorsViewController : UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return datasource.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! DayCellTableViewCell
		cell.backgroundColor = UIColor.white
		cell.dayLabel.text = datasource[indexPath.row]
		cell.descrioption.text = "Терапевт"
		return cell
	}
}

extension DoctorsViewController : UITableViewDelegate {

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 200
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

		///  вынести отображение вью черех координатор
		let viewController = DoctorSpecialities()
		present(viewController, animated: true, completion: nil)
	}
}
