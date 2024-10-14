//
//  SettingsDetailViewController.swift
//  ScalableRoutingExample
//
//  Created by Klaudius Ivan on 10/13/24.
//


import UIKit
import DomainModule

public class SettingsDetailViewController: UIViewController {
    public var router: SettingsDetailRouter?

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        self.title = "Settings Detail"

        let backButton = UIButton(type: .system)
        backButton.setTitle("Back to Settings", for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)

        NSLayoutConstraint.activate([
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc func backButtonTapped() {
        router?.backToSettings()
    }
}
