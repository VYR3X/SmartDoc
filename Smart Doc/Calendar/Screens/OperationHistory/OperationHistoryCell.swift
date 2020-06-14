//
//  OperationHistoryCell.swift
//  Smart Doc
//
//  Created by 17790204 on 28/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

/// Ячейка - с  описанием талона на прием
class OperationHistoryCell: UITableViewCell {

	private struct Constants {
		static let standardOffset: CGFloat = 25
	}

	/// Картинка c фотографией врача
	let profileImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false

//		let screenSize: CGRect = UIScreen.main.bounds
//		imageView.layer.cornerRadius = (screenSize.height / 7) / 2

		imageView.layer.cornerRadius = 25
		imageView.backgroundColor = .ligthGreenColor

		imageView.layer.shadowColor = UIColor.black.cgColor
		imageView.layer.shadowOpacity = 1
		imageView.layer.shadowOffset = .zero
		imageView.layer.shadowRadius = 7
		return imageView
	}()

	/// Время и дата записи к врачу
	let dateTimeLabel: UILabel = {
		let label = UILabel()
		label.sizeToFit()
		label.textColor = UIColor.gray
		label.font = UIFont.boldSystemFont(ofSize: 20)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	/// Название специальности врача
	let specialitiesNameLabel: UILabel = {
		let label = UILabel()
		label.sizeToFit()
		label.textColor = UIColor.gray
		label.font = UIFont.boldSystemFont(ofSize: 25)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	/// Адрес поликлиники
	let addressPolyclicsLabel: UILabel = {
		let label = UILabel()
		label.sizeToFit()
		label.textColor = UIColor.gray
		label.font = UIFont.boldSystemFont(ofSize: 20)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	private let bubbleView: UIView = {
		let view = UIView()
		view.layer.cornerRadius = 10
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .white
		return view
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		backgroundColor = .clear
		addSubview(bubbleView)
		bubbleView.addSubviews(profileImageView,
							   specialitiesNameLabel,
							   dateTimeLabel,
							   addressPolyclicsLabel)
		setupView()
	}

	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	func setupView() {

		NSLayoutConstraint.activate([
			bubbleView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
			bubbleView.rightAnchor.constraint(equalTo: rightAnchor, constant: -Constants.standardOffset),
			bubbleView.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.standardOffset),
			bubbleView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),

			profileImageView.heightAnchor.constraint(equalToConstant: 75),
			profileImageView.widthAnchor.constraint(equalToConstant: 75),
			profileImageView.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 25),
			profileImageView.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 20),

			specialitiesNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
			specialitiesNameLabel.heightAnchor.constraint(equalToConstant: 25),
			specialitiesNameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: Constants.standardOffset),
			specialitiesNameLabel.rightAnchor.constraint(equalTo: bubbleView.rightAnchor, constant: -Constants.standardOffset),

			dateTimeLabel.bottomAnchor.constraint(equalTo: specialitiesNameLabel.topAnchor, constant: -10),
			dateTimeLabel.heightAnchor.constraint(equalToConstant: 30),
			dateTimeLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: Constants.standardOffset),
			dateTimeLabel.rightAnchor.constraint(equalTo: bubbleView.rightAnchor, constant: -Constants.standardOffset),

			addressPolyclicsLabel.topAnchor.constraint(equalTo: specialitiesNameLabel.bottomAnchor, constant: 15),
			addressPolyclicsLabel.heightAnchor.constraint(equalToConstant: 20),
			addressPolyclicsLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: Constants.standardOffset),
			addressPolyclicsLabel.rightAnchor.constraint(equalTo: bubbleView.rightAnchor, constant: -Constants.standardOffset),

		])
	}

}

