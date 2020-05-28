//
//  GenreCollectionDelegate.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 28/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

/// Делегат для коллекшн вью со списком специальностей на главном экране
final class DoctorSpecialitiesCollectionDelegate: NSObject {

	let genresArray : [String] = ["Терапевт", "Хирург", "Стоматолог",
								  "Невролог", "Офтальмолог", "Оториноларинголог",
								  "Педиатр"];

	//"Стоматолог", // A417276AC757742CE0530100007F6A68
	//	"Терапевт", // 7F7DA9355EAAF96FE0530100007F0F8B
	//	"Хирург", // 7FA60C0CEEE364F3E0530100007F82C1

	private let listener: MainScreenPresentableListener?

	init(listener: MainScreenPresentableListener) {
		self.listener = listener
	}
}

extension DoctorSpecialitiesCollectionDelegate: UICollectionViewDelegate {

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		// пока передаем терапевта для теста
		listener?.didTapSpecialitiesCell(resourceID: "7F7DA9355EAAF96FE0530100007F0F8B")
		print("Выбранная специализация врача: 7F7DA9355EAAF96FE0530100007F0F8B")
	}

}

extension DoctorSpecialitiesCollectionDelegate : UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {


			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "genres",for: indexPath) as? GenreCollectionViewCell else {
				return UICollectionViewCell()
			}
			cell.genreNameLabel.text = genresArray[indexPath.item]
			cell.layer.cornerRadius = 20
			return cell
	}

	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

		return genresArray.count

	}
}

extension DoctorSpecialitiesCollectionDelegate : UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

			let label = UILabel(frame: CGRect.zero)
			label.text = genresArray[indexPath.item]
			label.sizeToFit()
			return CGSize(width: label.frame.width + 40 , height: 36)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

			return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

		return 16
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

		return 8
	}
}

