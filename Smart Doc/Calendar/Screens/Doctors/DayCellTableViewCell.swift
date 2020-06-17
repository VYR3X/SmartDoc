//
//  DayCellTableViewCell.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 30/03/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

/// Ячейка с врачами
/// TODO:  поменять название вообще не понтно что тут написано 
class DayCellTableViewCell: UITableViewCell {

	private struct Constants {
		static let standardOffset: CGFloat = 25
	}

	let cellView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.blue
		view.layer.cornerRadius = 10
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor(red: 144/255, green: 238/255, blue: 144/255, alpha: 1)
		return view
	}()

	let picture: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		return image
	}()

	let dayLabel: UILabel = {
		let label = UILabel()
		label.sizeToFit()
		label.text = "Day 1"
		label.textColor = UIColor.black
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
		cellView.addSubview(picture)
		cellView.addSubview(dayLabel)
		cellView.addSubview(descrioption)
		setupView()
	}

	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	private func setupView() {

		NSLayoutConstraint.activate([

			cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
			cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Constants.standardOffset),
			cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Constants.standardOffset),
			cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),

			picture.heightAnchor.constraint(equalToConstant: 56),
			picture.widthAnchor.constraint(equalToConstant: 56),
			picture.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 25),
			picture.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 20),

			dayLabel.heightAnchor.constraint(equalToConstant: 20),
			dayLabel.widthAnchor.constraint(equalToConstant: 327),
			dayLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 25),
			dayLabel.leftAnchor.constraint(equalTo: picture.rightAnchor, constant: 20),

			descrioption.heightAnchor.constraint(equalToConstant: 20),
			descrioption.widthAnchor.constraint(equalToConstant: 200),
			descrioption.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 4),
			descrioption.leftAnchor.constraint(equalTo: picture.rightAnchor, constant: 20),

			])
	}

}

