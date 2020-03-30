//
//  DoctorSpecialitiesCell.swift
//  Smart Doc
//
//  Created by 17790204 on 30/03/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

class DoctorSpecialitiesCell: UITableViewCell {

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	let cellView: UIView = {
		let view = UIView()
		view.layer.cornerRadius = 10
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor(red: 0, green: 255, blue: 127, alpha: 1)
		return view
	}()

	let dayLabel: UILabel = {
		let label = UILabel()
		label.sizeToFit()
		label.textColor = UIColor.gray
		label.font = UIFont.boldSystemFont(ofSize: 25)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		addSubview(cellView)
		cellView.addSubview(dayLabel)
		setupView()
	}

	func setupView() {

		NSLayoutConstraint.activate([

			cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
			cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
			cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
			cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),

			dayLabel.heightAnchor.constraint(equalToConstant: 20),
			dayLabel.widthAnchor.constraint(equalToConstant: 100),
			dayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			dayLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
			])
	}

}

