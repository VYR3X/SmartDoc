//
//  MovieWithDescriptionCollectionDelegate.swift
//  Smart Doc
//
//  Created by 17790204 on 28/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit


class DoctorsPhotoCollectionViewDelegate : NSObject {

	private let listener: MainScreenPresentableListener?

	private let doctorsPhotos = ["doc", "doc", "doc",
								 "doc", "doc", "doc",
								 "doc", "doc", "doc",
								 "doc", "doc"]

	init(listener: MainScreenPresentableListener) {
		self.listener = listener
	}
}

extension DoctorsPhotoCollectionViewDelegate: UICollectionViewDelegate {

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		listener?.didTapDoctorsPhoto()
	}

}

extension DoctorsPhotoCollectionViewDelegate : UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pikachu",for: indexPath) as? DoctorsPhotoCollectionViewCell else {
			return UICollectionViewCell()
		}
		cell.trailerImageView.image = UIImage(named: doctorsPhotos[indexPath.row])
		return cell
	}

	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return doctorsPhotos.count
	}
}

extension DoctorsPhotoCollectionViewDelegate : UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

		return CGSize(width: 307 , height: 180 )
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

		return UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 0)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

		return 24

	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

		return 16

	}
}

