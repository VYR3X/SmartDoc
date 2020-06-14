//
//  ReceptionNavigationController.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 01/06/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

/// Навигейшн контроллер, на котором отображаются все экраны для записи в крачу
final class ReceptionNavigationController: UINavigationController {

	override init(rootViewController: UIViewController) {
		super.init(rootViewController: rootViewController)
		navigationBar.isHidden = true
	}

	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

