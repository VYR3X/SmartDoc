//
//  DayCellTableViewCell.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 30/03/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

class DayCellTableViewCell: UITableViewCell {

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	let cellView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.blue
		view.layer.cornerRadius = 10
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor(red: 144/255, green: 238/255, blue: 144/255, alpha: 1)
		return view
	}()

	let dayLabel: UILabel = {
		let label = UILabel()
		label.sizeToFit()
		label.text = "Day 1"
		label.textColor = UIColor.gray
		label.font = UIFont.boldSystemFont(ofSize: 20)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	let descrioption: UILabel = {
		let label = UILabel()
		label.text = "Day 1"
		label.textColor = UIColor.gray
		label.font = UIFont.boldSystemFont(ofSize: 16)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		addSubview(cellView)
		cellView.addSubview(dayLabel)
		cellView.addSubview(descrioption)
		setupView()
	}

	func setupView() {

		NSLayoutConstraint.activate([

			cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
			cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
			cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
			cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),

			dayLabel.heightAnchor.constraint(equalToConstant: 20),
			dayLabel.widthAnchor.constraint(equalToConstant: 327),
			dayLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 45),
			dayLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 20),

			descrioption.heightAnchor.constraint(equalToConstant: 20),
			descrioption.widthAnchor.constraint(equalToConstant: 200),
			descrioption.topAnchor.constraint(equalTo: dayLabel.topAnchor, constant: 45),
			descrioption.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 20),

			])
	}

}

