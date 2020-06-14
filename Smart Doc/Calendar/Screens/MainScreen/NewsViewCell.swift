//
//  NewsViewCell.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 28/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

/// Ячейка с новостями
final class NewsViewCell: UICollectionViewCell {

	/// Картинка для новости
	let trailerImageView: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleAspectFill
		image.layer.cornerRadius = 16
		image.backgroundColor = UIColor.white
		image.clipsToBounds = true
		return image
	}()

	/// Заголовок новости
	let titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .left
		label.textColor = .white
		label.text = "Новость 1"
		label.backgroundColor = .clear
		label.font = UIFont.systemFont(ofSize: 17)
		return label
	}()

	/// Подзаголовок новости
	let subtitleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .left
		label.text = "комментарий"
		label.textColor = .white
		label.backgroundColor = .clear
		label.font = UIFont.systemFont(ofSize: 13)
		return label
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setUpConstraint()
	}

	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	private func setUpConstraint() {

		addSubview(trailerImageView)
		addSubview(titleLabel)
		addSubview(subtitleLabel)

		NSLayoutConstraint.activate([
			trailerImageView.heightAnchor.constraint(equalToConstant: 140),
			trailerImageView.widthAnchor.constraint(equalToConstant: 248),
			trailerImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),

			titleLabel.heightAnchor.constraint(equalToConstant: 22),
			titleLabel.widthAnchor.constraint(equalToConstant: 248),
			titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 148),
			titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),

			subtitleLabel.heightAnchor.constraint(equalToConstant: 16),
			subtitleLabel.widthAnchor.constraint(equalToConstant: 248),
			subtitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 174),
			subtitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 0)
		])
	}

}

