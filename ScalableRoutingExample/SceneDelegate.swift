//
//  SceneDelegate.swift
//  ScalableRoutingExample
//
//  Created by Klaudius Ivan on 10/13/24.
//

import UIKit
import HomeModule
import DetailModule
import SettingsModule
import DomainModule

/// The `SceneDelegate` is responsible for setting up the window and initializing the app's navigation structure.
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var appRouter: AppRouter?

    /// Called when the scene is connected to the app session.
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let homeNavController = UINavigationController()
        let settingsNavController = UINavigationController()
        let detailNavController = UINavigationController()

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [homeNavController, detailNavController, settingsNavController]
        tabBarController.viewControllers?[TabPage.home.rawValue] = homeNavController
        tabBarController.viewControllers?[TabPage.detail.rawValue] = detailNavController
        tabBarController.viewControllers?[TabPage.settings.rawValue] = settingsNavController
        
        homeNavController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: TabPage.home.rawValue)
        settingsNavController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: TabPage.settings.rawValue)
        detailNavController.tabBarItem = UITabBarItem(title: "Detail", image: UIImage(systemName: "doc.text"), tag: TabPage.detail.rawValue)

        // Initialize the AppRouter
        appRouter = AppRouter(tabBarController: tabBarController)

        // Register route handlers
        appRouter?.registerRoute(identifier: .home, handler: HomeRoute(navigationController: homeNavController, appRouter: appRouter!))
        appRouter?.registerRoute(identifier: .settings, handler: SettingsRoute(navigationController: settingsNavController, appRouter: appRouter!))
        appRouter?.registerRoute(identifier: .detail(dependency: nil), handler: DetailRoute(navigationController: detailNavController, appRouter: appRouter!))
        appRouter?.registerRoute(identifier: .subDetail(dependency: nil), handler: SubDetailRoute(navigationController: detailNavController, appRouter: appRouter!))
        appRouter?.registerRoute(identifier: .settingsDetail, handler: SettingsDetailRoute(navigationController: settingsNavController, appRouter: appRouter!))

        // Start root controllers
        appRouter?.route(screen: .settings, source: settingsNavController, navigationType: .open(type: .root()))
        appRouter?.route(screen: .detail(dependency: DetailDependency(itemID: 1, itemName: "Initialization")), source: detailNavController, navigationType: .open(type: .root()))
        appRouter?.route(screen: .home, source: homeNavController, navigationType: .open(type: .root()))

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}
