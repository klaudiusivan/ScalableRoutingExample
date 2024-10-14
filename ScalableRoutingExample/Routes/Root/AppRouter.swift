//
//  AppRouter.swift
//  ScalableRoutingExample
//
//  Created by Klaudius Ivan on 10/13/24.
//

import Foundation
import UIKit
import HomeModule
import DetailModule
import SettingsModule
import DomainModule


/// The main application router responsible for handling inter-module navigation.
public class AppRouter {
    
    /// A dictionary mapping screen identifiers to their respective route handlers.
    private var routeHandlers: [ScreenIdentifier: Route] = [:]

    private let tabBarController: UITabBarController

    /// Initializes a new instance of `AppRouter`.
    ///
    /// - Parameters:
    ///   - tabBarController: The main `UITabBarController` of the app.
    ///   - homeNavController: The navigation controller for the Home screen.
    ///   - settingsNavController: The navigation controller for the Settings screen.
    ///   - detailNavController: The navigation controller for the Detail screen.
    public init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }

    /// Registers a route handler for a specific screen identifier.
    ///
    /// - Parameters:
    ///   - identifier: The screen identifier to register.
    ///   - handler: The route handler for the screen.
    public func registerRoute(identifier: ScreenIdentifier, handler: Route) {
        routeHandlers[identifier] = handler
    }

    /// Routes to the specified screen based on the screen identifier.
    ///
    /// - Parameters:
    ///   - source: The source from where the route starts (e.g., a UIViewController or any other entity).
    ///   - completion: A closure to be executed upon route completion, allowing the caller to handle post-route actions.
    ///   - identifier: The screen identifier to register.
    public func route(screen identifier: ScreenIdentifier? = nil, source: UIViewController? = nil, navigationType: NavigationType) {
        if let identifier {
            routeHandlers[identifier]?.start(from: source, using: identifier, navigationType: navigationType)
        } else {
            navigate(navigationType: navigationType)
        }
    }
    /**
     Opens the specified tab page by selecting the corresponding tab in the tab bar controller.
     
     - Parameter tabPage: The `TabPage` to open. The selected tab is based on the raw value of the `TabPage`, which corresponds to the index in the tab bar.
     
     # Example:
     ```
     open(tabPage: .home) // This will select the 'Home' tab in the tab bar controller.
     ```
     */
    public func open(tabPage: TabPage) {
        tabBarController.selectedIndex = tabPage.rawValue
    }
    
    /**
     Centralize navigation logic for each Route to Navigates from the source view controller to the destination view controller based on the provided `NavigationType`.
     
     - Parameters:
        - source: The view controller from which the navigation is initiated. If `nil`, the top-most view controller in the app will be used.
        - destination: The view controller to which the navigation will occur. This is required for `push`, `present`, and `root` navigation types.
        - navigationType: Specifies the type of navigation to perform (open or close) and additional behaviors such as animations, presentation style, and whether the tab bar should be hidden.
     
     # Navigation Types:
     
     - `open(type:)`: Opens a new view controller using different methods:
        - `.push(animated:hidesTabBar:completion)`: Pushes a new view controller onto the navigation stack.
        - `.present(animated:presentationStyle:completion)`: Presents a view controller modally.
        - `.root(animated:)`: Replaces the root view controller of the navigation stack with the destination.
     
     - `close(type:)`: Closes a view controller using different methods:
        - `.pop(animated:completion)`: Pops the top view controller from the navigation stack.
        - `.dismiss(animated:completion)`: Dismisses the presented view controller.
        - `.popToViewController(viewController:animated:completion)`: Pops to a specific view controller in the navigation stack.
        - `.popToRoot(animated:completion)`: Pops to the root view controller in the navigation stack.
     
     - Note: The `source` parameter defaults to `nil`, which will use the top-most view controller in the app if not provided.
     
     # Example:
     ```
     // Pushes a view controller with animation and hides the tab bar
     navigate(from: currentVC, to: destinationVC, navigationType: .open(type: .push(animated: true, hidesTabBar: true, completion: nil)))
     
     // Presents a view controller modally
     navigate(from: currentVC, to: destinationVC, navigationType: .open(type: .present(animated: true, presentationStyle: .fullScreen, completion: nil)))
     
     // Pops to the root view controller in the navigation stack
     navigate(navigationType: .close(type: .popToRoot(animated: true, completion: nil)))
     ```
     */
    public func navigate(from source: UIViewController? = nil, to destination: UIViewController? = nil, navigationType: NavigationType) {
        guard let source = source ?? UIApplication.shared.topMostViewController() else { return }
        switch navigationType {
        case let .open(type):
            switch type {
            case .push(animated: let animated, hidesTabBar: let hidesTabBar, completion: let completion):
                guard let destination else { return }
                destination.hidesBottomBarWhenPushed = hidesTabBar
                source.navigationController?.pushViewController(destination, animated: animated)
                completion?()
                
            case .present(animated: let animated, presentationStyle: let presentationStyle, completion: let completion):
                guard let destination else { return }
                destination.modalPresentationStyle = presentationStyle
                source.present(destination, animated: animated, completion: completion)
                
            case .root(animated: let animated):
                guard let destination else { return }
                switch source {
                case is UINavigationController:
                    let sourceNavigationController = source as! UINavigationController
                    sourceNavigationController.setViewControllers([destination], animated: animated)
                
                default:
                    if let navigationController = source.navigationController {
                        navigationController.setViewControllers([destination], animated: animated)
                    }
                    
                    break
                }
            }
            
        case let .close(type):
            switch type {
            case .pop(animated: let animated, completion: let completion):
                source.navigationController?.popViewController(animated: animated)
                completion?()
                
            case .dismiss(animated: let animated, completion: let completion):
                source.dismiss(animated: animated, completion: completion)
                
            case .popToViewController(viewController: let viewController, animated: let animated, completion: let completion):
                source.navigationController?.popToViewController(viewController, animated: animated)
                completion?()
                
            case .popToRoot(animated: let animated, completion: let completion):
                source.navigationController?.popToRootViewController(animated: animated)
                completion?()
            }
        }
    }
}
