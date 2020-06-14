//
//  GenreCollectionViewCell.swift
//  Smart Doc
//
//  Created by 17790204 on 28/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {

	let genreNameLabel : UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = label.font.withSize(15)
		label.textAlignment = .center
		return label
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)

		backgroundColor = .gray4
		addSubview(genreNameLabel)
		self.setUpConstraintForGenreCollectionView()
	}

	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	func setUpConstraintForGenreCollectionView() {
		NSLayoutConstraint.activate([
			genreNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
			genreNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
			genreNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
			])
	}

}

