//
//  TimeTableCollectionViewCell.swift
//  Smart Doc
//
//  Created by 17790204 on 19/04/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

/// Ячейка с карточкой подборки в коллекции
final class TimeTableCollectionViewCell: UICollectionViewCell {

	private struct Constants {
		static let horizontalIndent: CGFloat = 16
		static let titleLabelFromImageIndent: CGFloat = 12
		static let imageHeight: CGFloat = 120
		static let sourceLabelFromTitleIndent: CGFloat = 4
	}

	let cellView: UIView = {
		let view = UIView()
		view.layer.cornerRadius = 10
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor(red: 144/255, green: 238/255, blue: 144/255, alpha: 1)
		return view
	}()

	/// Заголовок
	lazy var titleLabel: UILabel = {
		let titleLabel = UILabel()
		titleLabel.sizeToFit()
		titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.textColor = .white
		return titleLabel
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}

	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	private func setupView() {
		addSubview(cellView)
		cellView.addSubview(titleLabel)
		setupConstraints()
	}

	private func setupConstraints() {
		NSLayoutConstraint.activate([

			cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
			cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
			cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
			cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),

			titleLabel.heightAnchor.constraint(equalToConstant: 35),
			titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
			titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
		])
	}
}

