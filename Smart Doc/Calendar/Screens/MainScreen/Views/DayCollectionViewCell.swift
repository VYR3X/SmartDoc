//
//  DayCollectionViewCell.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 16/02/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

///  Ячейка описывающая день недели
final class DayCollectionViewCell: UICollectionViewCell {

	/// День недели лейбл
	let dayLabel: UILabel = {
		let label = UILabel()
		label.text = "00"
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 16)
		label.textColor = Colors.darkGray
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = UIColor.clear
		layer.cornerRadius = 5
		layer.masksToBounds = true
		setupViews()
	}

	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	private func setupViews() {
		addSubview(dayLabel)

		NSLayoutConstraint.activate([
			dayLabel.topAnchor.constraint(equalTo: topAnchor),
			dayLabel.leftAnchor.constraint(equalTo: leftAnchor),
			dayLabel.rightAnchor.constraint(equalTo: rightAnchor),
			dayLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}

}
