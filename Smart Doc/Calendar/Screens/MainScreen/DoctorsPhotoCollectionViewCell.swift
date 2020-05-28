//
//  MovieWithDescriptionCollectionViewCell.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 28/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

/// Ячейка с фотографией врача
class DoctorsPhotoCollectionViewCell: UICollectionViewCell {

	private let trailerImageView: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.layer.cornerRadius = 16
		image.backgroundColor = .ligthGreenColor
		return image
	}()

	private lazy var doctorNameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .left
		label.textColor = .black
		label.text = "Смирнов Иван Иванович"
		label.backgroundColor = .white
		label.numberOfLines = 0
		label.font = UIFont.systemFont(ofSize: 17)
		return label
	}()

	private let filmGenreLabel : UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .left
		label.textColor = .black
		label.text = "Терапевт"
		label.backgroundColor = .white
		label.font = UIFont.systemFont(ofSize: 17)
		return label
	}()

	private lazy var trailerRatingLabel : UILabel = {
		let label = UILabel()
		label.sizeToFit()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .left
		label.textColor = .black
		label.text = "Оценка: 8.9"
		label.backgroundColor = .white
		label.numberOfLines = 0
		label.font = UIFont.systemFont(ofSize: 17)
		return label
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setUpConstraintForFilmView()
	}

	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	private func setUpConstraintForFilmView () {

		addSubviews(trailerImageView, doctorNameLabel, filmGenreLabel, trailerRatingLabel)

		NSLayoutConstraint.activate([

			trailerImageView.heightAnchor.constraint(equalToConstant: 180),
			trailerImageView.widthAnchor.constraint(equalToConstant: 120),
			trailerImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),

			doctorNameLabel.heightAnchor.constraint(equalToConstant: 44),
			doctorNameLabel.widthAnchor.constraint(equalToConstant: 175),
			doctorNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
			doctorNameLabel.leftAnchor.constraint(equalTo: trailerImageView.rightAnchor, constant: 12),

			filmGenreLabel.heightAnchor.constraint(equalToConstant: 16),
			filmGenreLabel.widthAnchor.constraint(equalToConstant: 164),
			filmGenreLabel.topAnchor.constraint(equalTo: doctorNameLabel.bottomAnchor, constant: 6),
			filmGenreLabel.leftAnchor.constraint(equalTo: trailerImageView.rightAnchor, constant: 12),
			// 30 -> 23
			trailerRatingLabel.heightAnchor.constraint(equalToConstant: 18),
			trailerRatingLabel.topAnchor.constraint(equalTo: filmGenreLabel.bottomAnchor, constant: 7),
			trailerRatingLabel.leftAnchor.constraint(equalTo: trailerImageView.rightAnchor, constant: 12)
			])
	}

}

