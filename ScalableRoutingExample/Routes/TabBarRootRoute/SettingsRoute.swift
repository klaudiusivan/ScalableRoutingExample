//
//  SettingsRoute.swift
//  ScalableRoutingExample
//
//  Created by Klaudius Ivan on 10/13/24.
//


import UIKit
import SettingsModule
import DomainModule

/// The route handler for the Settings screen, conforming to `Route` and `SettingsRouter`.
///
/// This route is responsible for managing navigation to the Settings screen.
public struct SettingsRoute: SettingsRouter, Route {
    private weak var appRouter: AppRouter?
    private weak var navigationController: UINavigationController?
    private weak var settingsViewController: UIViewController?

    /// Initializes a new instance of `SettingsRoute`.
    ///
    /// - Parameters:
    ///   - navigationController: The navigation controller used for navigation.
    ///   - appRouter: The main application router.
    public init(navigationController: UINavigationController, appRouter: AppRouter) {
        self.appRouter = appRouter
        self.navigationController = navigationController
    }

    /// Starts the Settings screen route.
    ///
    /// - Parameters:
    ///   - source: The source from where the route is initiated (e.g., a view controller).
    ///   - completion: A closure called after the route is completed.
    public mutating func start(from source: UIViewController?, using identifier: ScreenIdentifier, navigationType: NavigationType) {
        if navigationType == .open(type: .root()) {
            guard let navigationController else { return }
            appRouter?.open(tabPage: .settings)
            
            appRouter?.navigate(from: navigationController, to: getViewController(), navigationType: navigationType)
        } else {
            appRouter?.navigate(from: source, to: makeController(), navigationType: navigationType)
        }
            
    }
    
    private mutating func getViewController() -> UIViewController {
        guard let settingsViewController else {
            return makeController()
        }
        return settingsViewController
    }
    private mutating func makeController() -> SettingsViewController {
        let settingsVC = SettingsViewController()
        settingsViewController = settingsVC
        settingsVC.router = self
        return settingsVC
    }

    /// Navigates to the Detail screen with an optional dependency.
    ///
    /// - Parameter dependency: The `DetailDependency` for the Detail screen. Can be `nil`.
    public func navigateToDetail(dependency: DetailDependency?) {
        appRouter?.route(screen: .settingsDetail, source: settingsViewController, navigationType: .open(type: .push()))
    }
}
