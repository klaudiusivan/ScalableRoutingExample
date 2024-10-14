//
//  SettingsViewController.swift
//  ScalableRoutingExample
//
//  Created by Klaudius Ivan on 10/13/24.
//


import UIKit
import DomainModule

/// The view controller for the Settings screen.
public class SettingsViewController: UIViewController {
    
    /// The router used to handle navigation actions.
    public var router: SettingsRouter?

    /// Called when the view is loaded into memory.
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        self.title = "Settings"
        
        // Create a button for navigating to the detail screen.
        let toDetailButton = UIButton(type: .system)
        toDetailButton.setTitle("Go to Detail", for: .normal)
        toDetailButton.addTarget(self, action: #selector(goToDetailTapped), for: .touchUpInside)

        // Layout button.
        toDetailButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toDetailButton)

        NSLayoutConstraint.activate([
            toDetailButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toDetailButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    /// Triggered when the button is tapped. Navigates to the Detail screen.
    @objc func goToDetailTapped() {
        let dependency = DetailDependency(itemID: 2, itemName: "Settings Item")
        router?.navigateToDetail(dependency: dependency)
    }
}
