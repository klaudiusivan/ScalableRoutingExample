//
//  HomeRoute.swift
//  ScalableRoutingExample
//
//  Created by Klaudius Ivan on 10/13/24.
//


import UIKit
import HomeModule
import DomainModule
import SwiftUI
import ScalableRouter

/// The route handler for the Home screen, conforming to `Route` and `HomeRouter`.
public struct HomeRoute: HomeRouter, Route {
    private weak var navigationController: UINavigationController?
    private weak var appRouter: AppRouter?
    private weak var homeController: UIViewController?

    /// Initializes a new instance of `HomeRoute`.
    ///
    /// - Parameters:
    ///   - navigationController: The navigation controller used for navigation.
    ///   - appRouter: The main application router.
    public init(navigationController: UINavigationController, appRouter: AppRouter) {
        self.navigationController = navigationController
        self.appRouter = appRouter
    }

    /// Starts the Home screen route.
    ///
    /// - Parameters:
    ///   - source: The source from where the route is initiated (e.g., a view controller).
    ///   - completion: A closure called after the route is completed.
    public mutating func start<ScreenId>(from source: UIViewController?, using identifier: ScreenId, navigationType: NavigationType) {
        guard let navigationController else { return }
        appRouter?.open(tabPage: .home)
        
        guard let homeController else {
            let homeVC = HomeViewController()
            homeController = homeVC
            homeVC.router = self
            appRouter?.navigate(from: navigationController, to: homeVC, navigationType: .open(type: .root()))
            return
        }
        
        appRouter?.navigate(from: navigationController, to: homeController, navigationType: .open(type: .root()))
    }

    /// Navigates to the Settings screen.
    public func navigateToSettings() {
        appRouter?.route(screen: .settings, source: homeController, navigationType: .open(type: .push()))
    }

    /// Navigates to the Detail screen with an optional dependency.
    ///
    /// - Parameter dependency: The `DetailDependency` for the Detail screen. Can be `nil`.
    public func navigateToDetail(dependency: DetailDependency?) {
        appRouter?.route(screen: .detail(dependency: dependency), navigationType: .open(type: .root()))
    }
}
