//
//  DoctorSpecialitiesCell.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 30/03/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

/// Ячейка со специальностью врача
class DoctorSpecialitiesCell: UITableViewCell {

	private struct Constants {
		static let standardOffset: CGFloat = 25
	}

	/// Название специальности врача
	let specialitiesNameLabel: UILabel = {
		let label = UILabel()
		label.sizeToFit()
		label.textColor = UIColor.gray
		label.font = UIFont.boldSystemFont(ofSize: 25)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	private let cellView: UIView = {
		let view = UIView()
		view.layer.cornerRadius = 10
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .white
		return view
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		backgroundColor = .clear
		addSubview(cellView)
		cellView.addSubview(specialitiesNameLabel)
		setupView()
	}

	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	func setupView() {

		NSLayoutConstraint.activate([
			cellView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
			cellView.rightAnchor.constraint(equalTo: rightAnchor, constant: -Constants.standardOffset),
			cellView.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.standardOffset),
			cellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),

			specialitiesNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
			specialitiesNameLabel.heightAnchor.constraint(equalToConstant: 30),
			specialitiesNameLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: Constants.standardOffset),
			specialitiesNameLabel.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -Constants.standardOffset)
		])
	}

}

