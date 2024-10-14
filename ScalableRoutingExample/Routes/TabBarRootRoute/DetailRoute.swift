//
//  DetailRoute.swift
//  ScalableRoutingExample
//
//  Created by Klaudius Ivan on 10/13/24.
//

import UIKit
import DetailModule
import DomainModule
import ScalableRouter

/// The route handler for the Detail screen, conforming to `Route` and `DetailRouter`.
///
/// This route is responsible for managing navigation to the Detail screen.
/// Detail Screen Can Be Tab Bar Root, and Another page detail.
public struct DetailRoute: DetailRouter, Route {
    private weak var navigationController: UINavigationController?
    private weak var appRouter: AppRouter?
    private weak var cachedDetailViewController: DetailViewController? // Cache the DetailVC weakly

    /// Initializes a new instance of `DetailRoute`.
    ///
    /// - Parameters:
    ///   - navigationController: The navigation controller used for navigation.
    ///   - appRouter: The main application router.
    public init(navigationController: UINavigationController, appRouter: AppRouter) {
        self.navigationController = navigationController
        self.appRouter = appRouter
    }

    /// Starts the Detail screen route.
    ///
    /// - Parameters:
    ///   - source: The source from where the route is initiated (e.g., a view controller).
    ///   - completion: A closure called after the route is completed.
    public mutating func start<ScreenId>(from source: UIViewController?, using identifier: ScreenId, navigationType: NavigationType) {
        
        guard let identifier = identifier as? ScreenIdentifier,
              case let .detail(dependency) = identifier,
              let dependency
        else {
            appRouter?.navigate(navigationType: navigationType)
            return
        }
        
        if navigationType == .open(type: .root()) {
            appRouter?.open(tabPage: .detail)
        }

        // Check if the cachedDetailViewController exists and reuse it if possible
        let detailVC: DetailViewController
        if let cachedVC = cachedDetailViewController, navigationType == .open(type: .root()) {
            // Reuse the cached view controller
            detailVC = cachedVC
        } else {
            // Create a new DetailViewController if not cached
            detailVC = DetailViewController(dependency: dependency)
            cachedDetailViewController = detailVC // Cache it weakly
            detailVC.router = self
        }

        // Use the AppRouter to navigate based on the navigation type
        appRouter?.navigate(from: source, to: detailVC, navigationType: navigationType)
    }
    
    /// Navigates back to the Home screen.
    public func backToHome() {
        appRouter?.route(screen: .home, navigationType: .open(type: .root(animated: true)))
    }
    
    // New function to handle navigation to SubDetailViewController
    public func routeToSubDetail(from source: UIViewController, dependency: DetailDependency) {
        appRouter?.route(screen: .subDetail(dependency: dependency), source: source, navigationType: .open(type: .push()))
    }
}
