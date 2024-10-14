//
//  SettingsDetailRoute.swift
//  ScalableRoutingExample
//
//  Created by Klaudius Ivan on 10/13/24.
//


import UIKit
import SettingsModule
import DomainModule
import ScalableRouter

/// The route handler for the Settings Detail screen, conforming to `Route` and `SettingsDetailRouter`.
public struct SettingsDetailRoute: SettingsDetailRouter, Route {
    private weak var navigationController: UINavigationController?
    private weak var appRouter: AppRouter?
    private weak var source: UIViewController?

    /// Initializes a new instance of `SettingsDetailRoute`.
    ///
    /// - Parameters:
    ///   - navigationController: The navigation controller used for navigation.
    ///   - appRouter: The main application router.
    public init(navigationController: UINavigationController, appRouter: AppRouter) {
        self.navigationController = navigationController
        self.appRouter = appRouter
    }

    /// Starts the Settings Detail screen route.
    ///
    /// - Parameters:
    ///   - source: The source from where the route is initiated (e.g., a view controller).
    ///   - completion: A closure called after the route is completed.
    public mutating func start<ScreenId>(from source: UIViewController?, using identifier: ScreenId, navigationType: NavigationType) {
        self.source = source
        let settingsDetailVC = SettingsDetailViewController()
        settingsDetailVC.router = self
        appRouter?.navigate(from: source, to: settingsDetailVC, navigationType: navigationType)
    }

    /// Navigates back to the Settings screen.
    public func backToSettings() {
        guard let source else { return }
        appRouter?.route(navigationType: .close(type: .popToViewController(viewController: source))
        )
    }
}
