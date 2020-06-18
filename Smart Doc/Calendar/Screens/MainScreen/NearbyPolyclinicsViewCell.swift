//
//  NearbyCinemaTableViewCell.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 28/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

/// Ячейка содержащая описание поликлиники
final class NearbyPolyclinicsViewCell: UITableViewCell {

	private let fullPolyclinicLocationInformationView : UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .clear
		return view
	}()

	/// Закругленная вью содержащая в себе рейтинг и картинку звезды
	private let subviewWithRating: UIView = {
		let view = UIView()
		view.sizeToFit()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor(red: 0, green: 0, blue: 0.078, alpha: 0.05)
		view.layer.cornerRadius = 7
		return view
	}()

	private let addressView : UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .clear
		return view
	}()

	/// Название поликлиники
	lazy var polyclinicNameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = label.font.withSize(17)
		label.font = UIFont.boldSystemFont(ofSize: 20.0)
		label.text = "Поликлиника №1"
		label.textAlignment = .left
		return label
	}()

	/// Адресс поликлиники
	let polyclinicAddressLabel : UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = label.font.withSize(15)
		label.text = "ул. Строителей"
		label.textAlignment = .left
		return label
	}()

	/// Расстояние до поликлиники
	let distanceToPolyclinicLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = label.font.withSize(15)
		label.text = "1,2км"
		return label
	}()

	/// Рейтинг поликлиники по шкале от 1 до 5
	let polyclinicRatingLabel : UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.boldSystemFont(ofSize: 14) // 14 -> 15
		label.text = "6.8"
		return label
	}()

	/// Картинка рейтинга - звезда
	private let polyclinicRatingImageView : UIImageView = {
		let image = UIImage(named: "stars")
		let imageView = UIImageView(image: image)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	/// Картинка навигации - компас
	private let navigationImageView : UIImageView = {
		let image = UIImage(named: "compass")
		let imageView = UIImageView(image: image)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupConstraint()
    }

	required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }

	func setupConstraint() {

		addSubview(fullPolyclinicLocationInformationView)
		addSubview(subviewWithRating)

		subviewWithRating.addSubview(polyclinicRatingLabel)
		subviewWithRating.addSubview(polyclinicRatingImageView)

		fullPolyclinicLocationInformationView.addSubview(addressView)

		addressView.addSubview(polyclinicNameLabel)
		addressView.addSubview(polyclinicAddressLabel)

		fullPolyclinicLocationInformationView.addSubview(navigationImageView)
		fullPolyclinicLocationInformationView.addSubview(distanceToPolyclinicLabel)

		NSLayoutConstraint.activate([

			fullPolyclinicLocationInformationView.widthAnchor.constraint(equalToConstant: 316),
			fullPolyclinicLocationInformationView.heightAnchor.constraint(equalToConstant: 96),
			fullPolyclinicLocationInformationView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
			fullPolyclinicLocationInformationView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
			fullPolyclinicLocationInformationView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
			fullPolyclinicLocationInformationView.rightAnchor.constraint(equalTo: rightAnchor, constant: -59),

			subviewWithRating.widthAnchor.constraint(equalToConstant: 59),
			subviewWithRating.topAnchor.constraint(equalTo: polyclinicNameLabel.topAnchor, constant: 0),
			subviewWithRating.bottomAnchor.constraint(equalTo: polyclinicAddressLabel.topAnchor, constant: 0),
			subviewWithRating.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),

			polyclinicRatingImageView.widthAnchor.constraint(equalToConstant: 16),
			polyclinicRatingImageView.heightAnchor.constraint(equalToConstant: 16),
			polyclinicRatingImageView.topAnchor.constraint(equalTo: topAnchor, constant: 14),
			polyclinicRatingImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -43),
			polyclinicRatingImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -66),

			polyclinicRatingLabel.widthAnchor.constraint(equalToConstant: 23),
			polyclinicRatingLabel.heightAnchor.constraint(equalToConstant: 18),
			polyclinicRatingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 13),
			polyclinicRatingLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
			polyclinicRatingLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -65),

			addressView.widthAnchor.constraint(equalToConstant: 303),
			addressView.heightAnchor.constraint(equalToConstant: 60),
			addressView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
			addressView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -36),
			addressView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),

			polyclinicNameLabel.widthAnchor.constraint(equalToConstant: 303),
			polyclinicNameLabel.heightAnchor.constraint(equalToConstant: 22),
			polyclinicNameLabel.rightAnchor.constraint(equalTo: addressView.rightAnchor, constant: 0),
			polyclinicNameLabel.bottomAnchor.constraint(equalTo: addressView.bottomAnchor, constant: -29),
			polyclinicNameLabel.leftAnchor.constraint(equalTo: addressView.leftAnchor, constant: 0),

			polyclinicAddressLabel.widthAnchor.constraint(equalToConstant: 303),
			polyclinicAddressLabel.heightAnchor.constraint(equalToConstant: 18),
			polyclinicAddressLabel.topAnchor.constraint(equalTo: addressView.topAnchor, constant: 33),
			polyclinicAddressLabel.rightAnchor.constraint(equalTo: addressView.rightAnchor, constant: 0),
			polyclinicAddressLabel.leftAnchor.constraint(equalTo: addressView.leftAnchor, constant: 0),

			navigationImageView.widthAnchor.constraint(equalToConstant: 16),
			navigationImageView.heightAnchor.constraint(equalToConstant: 16),
			navigationImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
			navigationImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -18),

			distanceToPolyclinicLabel.widthAnchor.constraint(equalToConstant: 43),
			distanceToPolyclinicLabel.heightAnchor.constraint(equalToConstant: 18),
			distanceToPolyclinicLabel.topAnchor.constraint(equalTo: topAnchor, constant: 61),
			distanceToPolyclinicLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 36),

		])
	}
}
