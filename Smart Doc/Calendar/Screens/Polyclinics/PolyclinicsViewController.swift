//
//  PolyclinicsViewController.swift
//  Smart Doc
//
//  Created by 17790204 on 10/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

/// Интерфейс взаимодействия с вью-контроллером экрана Polyclinics.
protocol PolyclinicsViewControllable: UIViewController {}

protocol PolyclinicsPresentableListener {

	func didLoad(_ viewController: PolyclinicsViewControllable)
}

final class PolyclinicsViewController: UIViewController, PolyclinicsViewControllable {

	// MARK: UI

    private let listener: PolyclinicsPresentableListener

    init(listener: PolyclinicsPresentableListener) {
        self.listener = listener
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
		// Configuration
		// didLoad(_:)
		listener.didLoad(self)
    }

    // MARK: PolyclinicsViewControllable
}
