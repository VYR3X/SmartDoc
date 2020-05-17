//
//  OperationHistoryViewController.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 05/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

/// Интерфейс взаимодействия с вью-контроллером экрана OperationHistory.
protocol OperationHistoryViewControllable: UIViewController {}

protocol OperationHistoryPresentableListener {

	func didLoad(_ viewController: OperationHistoryViewControllable)
}

/// Экран история записей к врачу 
final class OperationHistoryViewController: UIViewController, OperationHistoryViewControllable {

    private let listener: OperationHistoryPresentableListener

	// MARK: UI

	private let descriptionLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.boldSystemFont(ofSize: 25)
		label.textColor = .gray
		label.text = "История приемов:"
		label.backgroundColor = .white
		return label
	}()

	private lazy var tableView : UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
		return tableView
	}()


    init(listener: OperationHistoryPresentableListener) {
        self.listener = listener
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
		// Configuration
		// didLoad(_:)
		listener.didLoad(self)
		view.backgroundColor = UIColor(red: 175/255, green: 242/255, blue: 250/255, alpha: 1)
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

extension OperationHistoryViewController : UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 5
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

//		let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! DoctorSpecialitiesCell

//		cell.dayLabel.text = datasource[indexPath.row]
		let cell = UITableViewCell()
		cell.backgroundColor = .orange
		return cell
	}
}

extension OperationHistoryViewController : UITableViewDelegate {

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100
	}
}
