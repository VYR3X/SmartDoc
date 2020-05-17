//
//  PolyclinicsViewController.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 10/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

/// Интерфейс взаимодействия с вью-контроллером экрана Polyclinics.
protocol PolyclinicsViewControllable: UIViewController {}

protocol PolyclinicsPresentableListener {

	func didLoad(_ viewController: PolyclinicsViewControllable)

	func openNextViewController()
}

final class PolyclinicsViewController: UIViewController, PolyclinicsViewControllable {

	// MARK: UI

	private let descriptionLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.boldSystemFont(ofSize: 25)
		label.textColor = .gray
		label.text = "Выберите поликлинникиу:"
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

    private let listener: PolyclinicsPresentableListener

    init(listener: PolyclinicsPresentableListener) {
        self.listener = listener
        super.init(nibName: nil, bundle: nil)
    }

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
		// Configuration
		// didLoad(_:)
		listener.didLoad(self)
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

    // MARK: PolyclinicsViewControllable
}

extension PolyclinicsViewController: UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 10
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! TimeTableCollectionViewCell

		//cell.titleLabel.text = datasourse?.row[indexPath.row].TIME_SHOW

		//if datasourse?.row[indexPath.row].STATE == 1 { cell.cellView.backgroundColor = .red }
		//print(datasourse?.row[indexPath.row].TIME_SHOW)

		return cell
	}
}

extension PolyclinicsViewController: UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		listener.openNextViewController()
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
