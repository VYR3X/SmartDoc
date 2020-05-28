//
//  NearbyCinemaTableViewCell.swift
//  Smart Doc
//
//  Created by 17790204 on 28/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

class NearbyPolyclinicsViewCell: UITableViewCell {

	let fullPolyclinicLocationInformationView : UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .clear
		return view
	}()

	let subviewWithRating : UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .clear
		return view
	}()

	let addressView : UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .clear
		return view
	}()

	let polyclinicNameLabel : UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = label.font.withSize(17)
		label.font = UIFont.boldSystemFont(ofSize: 20.0)
		label.text = "Зеленоградская гор. больница №1"
		label.textAlignment = .left
		return label
	}()

	let polyclinicAddressLabel : UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = label.font.withSize(15)
		label.text = "Пресненская набережная, 2"
		label.textAlignment = .left
		return label
	}()

	let distanceToThePolyclinicLabel : UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = label.font.withSize(15)
		label.text = "1,2км"
		return label
	}()

	let subwayStationLabel : UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Трубная"
		label.font = label.font.withSize(15)
		return label
	}()

	let movietheaterRatingLabel : UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.boldSystemFont(ofSize: 14) // 14 -> 15
		label.text = "6.8"
		return label
	}()

	let subwayStationColorPointImageView : UIImageView = {
		let image = UIImage(named: "heart")!
		let imageView = UIImageView(image: image)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	let movietheaterRatingImageView : UIImageView = {

		let image = UIImage(named: "heart")!
		let imageView = UIImageView(image: image)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	let navigationImageView : UIImageView = {
		let image = UIImage(named: "heart")!
		let imageView = UIImageView(image: image)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

		setupConstraint()

    }

	func setupConstraint() {

		addSubview(fullPolyclinicLocationInformationView)
		addSubview(subviewWithRating)

		subviewWithRating.addSubview(movietheaterRatingLabel)
		subviewWithRating.addSubview(movietheaterRatingImageView)

		fullPolyclinicLocationInformationView.addSubview(addressView)

		addressView.addSubview(polyclinicNameLabel)
		addressView.addSubview(polyclinicAddressLabel)

		fullPolyclinicLocationInformationView.addSubview(navigationImageView)
		fullPolyclinicLocationInformationView.addSubview(distanceToThePolyclinicLabel)

		fullPolyclinicLocationInformationView.addSubview(subwayStationColorPointImageView)
		fullPolyclinicLocationInformationView.addSubview(subwayStationLabel)

		NSLayoutConstraint.activate([

			fullPolyclinicLocationInformationView.widthAnchor.constraint(equalToConstant: 316),
			fullPolyclinicLocationInformationView.heightAnchor.constraint(equalToConstant: 96),
			fullPolyclinicLocationInformationView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
			fullPolyclinicLocationInformationView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
			fullPolyclinicLocationInformationView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
			fullPolyclinicLocationInformationView.rightAnchor.constraint(equalTo: rightAnchor, constant: -59),

			subviewWithRating.widthAnchor.constraint(equalToConstant: 59),
			subviewWithRating.heightAnchor.constraint(equalToConstant: 96),
			subviewWithRating.topAnchor.constraint(equalTo: topAnchor, constant: 0),
			subviewWithRating.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
			subviewWithRating.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),

			movietheaterRatingImageView.widthAnchor.constraint(equalToConstant: 16),
			movietheaterRatingImageView.heightAnchor.constraint(equalToConstant: 16),
			movietheaterRatingImageView.topAnchor.constraint(equalTo: topAnchor, constant: 14),
			movietheaterRatingImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -43),
			movietheaterRatingImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -66),

			movietheaterRatingLabel.widthAnchor.constraint(equalToConstant: 23),
			movietheaterRatingLabel.heightAnchor.constraint(equalToConstant: 18),
			movietheaterRatingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 13),
			movietheaterRatingLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
			movietheaterRatingLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -65),

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
			navigationImageView.topAnchor.constraint(equalTo: topAnchor, constant: 62),
			navigationImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
			navigationImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -18),

			distanceToThePolyclinicLabel.widthAnchor.constraint(equalToConstant: 43),
			distanceToThePolyclinicLabel.heightAnchor.constraint(equalToConstant: 18),
			distanceToThePolyclinicLabel.topAnchor.constraint(equalTo: topAnchor, constant: 61),
			distanceToThePolyclinicLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -240),
			distanceToThePolyclinicLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 36),

			subwayStationColorPointImageView.widthAnchor.constraint(equalToConstant: 16),
			subwayStationColorPointImageView.heightAnchor.constraint(equalToConstant: 16),
			subwayStationColorPointImageView.topAnchor.constraint(equalTo: topAnchor, constant: 62),
			subwayStationColorPointImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 87),
			subwayStationColorPointImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -18),

			subwayStationLabel.widthAnchor.constraint(equalToConstant: 60),
			subwayStationLabel.heightAnchor.constraint(equalToConstant: 18),
			subwayStationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 61),
			subwayStationLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -17),
			subwayStationLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 107)

		])
	}

    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)
    }

}
