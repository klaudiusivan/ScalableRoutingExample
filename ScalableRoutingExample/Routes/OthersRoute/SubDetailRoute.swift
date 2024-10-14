//
//  SubDetailRoute.swift
//  ScalableRoutingExample
//
//  Created by Klaudius Ivan on 10/13/24.
//

import UIKit
import DetailModule
import DomainModule

/// The route handler for the Sub Detail screen, conforming to `Route` and `SubDetailRouter`.
///
/// This route is responsible for navigating to the Sub Detail screen.
public struct SubDetailRoute: SubDetailRouter, Route {
    private weak var navigationController: UINavigationController?
    private weak var appRouter: AppRouter?
    private weak var source: UIViewController?

    /// Initializes a new instance of `SubDetailRoute`.
    ///
    /// - Parameters:
    ///   - navigationController: The navigation controller used for navigation.
    ///   - appRouter: The main application router.
    public init(navigationController: UINavigationController, appRouter: AppRouter) {
        self.navigationController = navigationController
        self.appRouter = appRouter
    }

    /// Starts the Sub Detail screen route.
    ///
    /// - Parameters:
    ///   - source: The source from where the route is initiated (e.g., a view controller).
    ///   - completion: A closure called after the route is completed.
    public mutating func start(from source: UIViewController?, using identifier: ScreenIdentifier, navigationType: NavigationType) {
        self.source = source
        let subDetailVC = SubDetailViewController(dependency: nil)
        subDetailVC.router = self
        appRouter?.navigate(from: source, to: subDetailVC, navigationType: navigationType)
    }

    /// Navigates back to the Detail screen.
    public func backToDetail() {
        guard let source else { return }
        appRouter?.route(navigationType: .close(type: .popToViewController(viewController: source, animated: true, completion: nil)))
    }
}
