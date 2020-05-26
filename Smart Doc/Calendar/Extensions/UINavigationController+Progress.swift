//
//  UINavigationController+Progress.swift
//  Smart Doc
//
//  Created by 17790204 on 22/05/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import UIKit

public let progressView = UIProgressView(progressViewStyle: .bar)

/// Работает но не супер выглядит

extension UINavigationController {

    public override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(progressView)
        let navBar = self.navigationBar

		self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[navBar]-0-[progressView]",
																options: .directionLeadingToTrailing, metrics: nil, views: ["progressView" : progressView, "navBar" : navBar]))
		self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[progressView]|",
																options: .directionLeadingToTrailing, metrics: nil, views: ["progressView" : progressView]))
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.setProgress(0.1, animated: false)
    }
}
