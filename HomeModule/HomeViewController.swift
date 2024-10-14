//
//  HomeViewController.swift
//  HomeModule
//
//  Created by Klaudius Ivan on 10/13/24.
//

import UIKit
import DomainModule

/// The view controller for the Home screen.
public class HomeViewController: UIViewController {
    
    /// The router used to handle navigation actions.
    public var router: HomeRouter?

    /// Called when the view is loaded into memory.
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Home"
        
        // Create buttons for navigation actions.
        let detailButton = UIButton(type: .system)
        detailButton.setTitle("Go to Detail", for: .normal)
        detailButton.addTarget(self, action: #selector(detailButtonTapped), for: .touchUpInside)

        let settingsButton = UIButton(type: .system)
        settingsButton.setTitle("Go to Settings", for: .normal)
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)

        // Layout buttons.
        detailButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(detailButton)
        view.addSubview(settingsButton)

        NSLayoutConstraint.activate([
            detailButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            settingsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            settingsButton.topAnchor.constraint(equalTo: detailButton.bottomAnchor, constant: 20)
        ])
    }

    /// Triggered when the detail button is tapped. Navigates to the Detail screen.
    @objc func detailButtonTapped() {
        let dependency = DetailDependency(itemID: 1, itemName: "Home Item")
        router?.navigateToDetail(dependency: dependency)
    }

    /// Triggered when the settings button is tapped. Navigates to the Settings screen.
    @objc func settingsButtonTapped() {
        router?.navigateToSettings()
    }
}
