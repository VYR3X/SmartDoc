//
//  ReseptionFlowAssembly.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 01/03/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

/// Сборщик флоу отмена оплаты билета
final class ReseptionFlowAssembly {

	//private weak var coordinator: Coordinator?
	private var orderID: String?

	private let services: ServiceAssembly

	//private weak var coordinator: PurchaseFlowCoordinator?

	init(services: ServiceAssembly) {
		self.services = services
	}

	func makeDoctorsViewController() {//-> UIViewController {
//		let coordinator = makeCoordinator()
//		let interactor = MainPurchaseInteractor(movieService: services.makeMovieService(),
//												cinemaService: services.makeCinemaService(),
//												cityService: services.makeCityService())
//		let presenter = MainPurchasePresenter(interactor: interactor, coordinator: coordinator)
//		let viewController = MainViewController(listener: presenter)
//		presenter.viewController = viewController
//		coordinator.rootViewController = viewController
		//return UIViewController()
	}

//	func makeMainViewController() -> UIViewController {
//		let coordinator = makeCoordinator()
//		let interactor = MainPurchaseInteractor(movieService: services.makeMovieService(),
//												cinemaService: services.makeCinemaService(),
//												cityService: services.makeCityService())
//		let presenter = MainPurchasePresenter(interactor: interactor, coordinator: coordinator)
//		let viewController = MainViewController(listener: presenter)
//		presenter.viewController = viewController
//		coordinator.rootViewController = viewController
//		return viewController
//	}


	/// Создает координатор
	///
		/// - Returns: координатор отмены оплаты
//	private func makeCoordinator() -> PurchaseFlowCoordinator {
//		if let coordinator = self.coordinator { return coordinator }
//		let coordinator = PurchaseFlowCoordinator(assembly: self)
//		self.coordinator = coordinator
//		return coordinator
//	}
}
