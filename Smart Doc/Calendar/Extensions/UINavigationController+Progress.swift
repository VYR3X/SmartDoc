//
//  UINavigationController+Progress.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 22/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

/// Вью прогресса отображения экранов во флоу оформления записи к врсчу
public let progressView: UIProgressView = {
	let view = UIProgressView(progressViewStyle: .bar)
	view.translatesAutoresizingMaskIntoConstraints = false
	view.trackTintColor = Colors.mainColor
	view.progressTintColor = Colors.ligthGreenColor
	view.setProgress(0.2, animated: false)
	return view
}()

extension UINavigationController {

    public override func viewDidLoad() {
        super.viewDidLoad()
		setupView()
    }

	private func setupView() {
		self.view.addSubview(progressView)
        let navBar = self.navigationBar
		progressView.bottomAnchor.constraint(equalTo: navBar.bottomAnchor).isActive = true
		progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		progressView.heightAnchor.constraint(equalToConstant: 7).isActive = true
	}
}

extension UINavigationBar {
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 151)
    }
}
