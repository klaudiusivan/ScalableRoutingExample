//
//  SubDetailViewController.swift
//  ScalableRoutingExample
//
//  Created by Klaudius Ivan on 10/13/24.
//


import UIKit
import DomainModule

/// The view controller for the Sub Detail screen.
public class SubDetailViewController: UIViewController {
    
    /// The router used to handle navigation actions.
    public var router: SubDetailRouter?
    
    /// The dependency for this view controller.
    public let dependency: DetailDependency?

    /// Initializes a new instance of `SubDetailViewController`.
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
        view.backgroundColor = .cyan
        self.title = dependency?.itemName ?? "Sub Detail"

        // Create a back button.
        let backButton = UIButton(type: .system)
        backButton.setTitle("Back to Detail", for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        // Layout back button.
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)

        NSLayoutConstraint.activate([
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    /// Triggered when the back button is tapped. Navigates back to the Detail screen.
    @objc func backButtonTapped() {
        router?.backToDetail()
    }
}
