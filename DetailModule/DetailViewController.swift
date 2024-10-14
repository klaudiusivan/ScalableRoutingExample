//
//  DetailViewController.swift
//  DetailModule
//
//  Created by Klaudius Ivan on 10/13/24.
//

import Foundation
import UIKit
import DomainModule

/// The view controller for the Detail screen.
public class DetailViewController: UIViewController {
    
    /// The router used to handle navigation actions.
    public var router: DetailRouter?
    
    /// The dependency for this view controller.
    public let dependency: DetailDependency?

    /// Initializes a new instance of `DetailViewController`.
    ///
    /// - Parameter dependency: The `DetailDependency` for this screen. Can be `nil`.
    public init(dependency: DetailDependency?) {
        self.dependency = dependency
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Called when the view is loaded into memory.
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        self.title = dependency?.itemName ?? "Detail"

        // Create a back button.
        let backButton = UIButton(type: .system)
        backButton.setTitle("Back to Home", for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        // Layout back button.
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)

        NSLayoutConstraint.activate([
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        setupSubDetailButton()
    }

    // Setting up the button with proper constraints and styling
    private func setupSubDetailButton() {
        let subDetailButton = UIButton(type: .system)
        subDetailButton.setTitle("Go to Sub Detail", for: .normal)
        subDetailButton.setTitleColor(.white, for: .normal)
        subDetailButton.backgroundColor = .systemBlue
        subDetailButton.layer.cornerRadius = 10
        subDetailButton.translatesAutoresizingMaskIntoConstraints = false
        
        subDetailButton.addTarget(self, action: #selector(navigateToSubDetail), for: .touchUpInside)
        view.addSubview(subDetailButton)
        
        // Add layout constraints for the button
        NSLayoutConstraint.activate([
            subDetailButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subDetailButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
            subDetailButton.widthAnchor.constraint(equalToConstant: 200),
            subDetailButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }


    @objc private func navigateToSubDetail() {
        router?.routeToSubDetail(from: self, dependency: dependency!)
    }
    /// Triggered when the back button is tapped. Navigates back to the Home screen.
    @objc func backButtonTapped() {
        router?.backToHome()
    }
}
