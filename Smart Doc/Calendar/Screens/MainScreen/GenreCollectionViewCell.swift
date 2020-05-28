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

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override init(frame: CGRect) {
		super.init(frame: frame)

		backgroundColor = UIColor(red: 0, green: 0, blue: 0.078, alpha: 0.04)
		addSubview(genreNameLabel)
		self.setUpConstraintForGenreCollectionView()
	}

	func setUpConstraintForGenreCollectionView (){

		NSLayoutConstraint.activate([
			genreNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
			genreNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
			genreNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
			])
	}

}

