# Swift Tabbed Navigation with Scalable Routing and AppRouter

This project demonstrates how to implement a **tab bar navigation** system in a Swift application, using an **AppRouter** to manage scalable screen transitions across different tabs. Each tab has its own **UINavigationController**, and the **AppRouter** efficiently handles navigation within and across tabs, making the architecture modular and extensible.

Additionally, the project is designed to showcase how features like **Push Notifications**, **Silent Push**, **Deep Linking**, and **In-App Push Notifications** could be integrated using a scalable routing architecture, but these features are not yet implemented.

## Features

- **Scalable Routing Logic**: The app uses a centralized and modular routing system that allows flexible navigation across various feature modules.
- **Tab Bar Navigation**: The app has three tabs — **Home**, **Settings**, and **Detail**.
- **Independent Navigation Stacks**: Each tab is managed by its own `UINavigationController`, ensuring independent navigation flows for each module.
- **AppRouter**: A central `AppRouter` facilitates navigation between screens and selects the appropriate tab with minimal coupling between view controllers.
- **SceneDelegate Registration**: The `AppRouter` is registered in the **SceneDelegate** to ensure it's accessible throughout the app's lifecycle and manages routing for all tabs.
- **Memory Leak Prevention**: The router is injected into view controllers using a `weak` reference, preventing retain cycles and memory leaks.
- **SubDetail Screen Navigation**: The **Detail** screen includes the option to navigate to a **SubDetail** screen for additional detailed content.
- **Designed for Future Extension**: The project is structured to support **Push Notifications**, **Silent Push**, **Deep Linking**, and **In-App Push**, but these features are not implemented yet.

> **Note**: While the architecture supports scalable routing and is designed for features like **Push Notifications**, **Silent Push**, **Deep Linking**, and **In-App Push**, these features are **not implemented** in this project. The following examples show how they could be added.

## Screens

1. **Home Tab**: Allows users to navigate to either the **Settings** or **Detail** screens.
2. **Settings Tab**: Displays settings information and allows navigation to the **Detail** screen.
3. **Detail Tab**: Displays detailed information based on passed `DetailDependency` and allows navigation to the **SubDetail** screen.

## Scalable Architecture

### 1. **AppRouter**

The `AppRouter` acts as the core of the navigation system, responsible for managing the transition between screens across different tabs. The scalable routing logic allows new routes and feature modules to be added easily without affecting existing navigation.

#### Responsibilities:
- **Screen Transitions**: Manages navigation to specific screens across multiple tabs.
- **Tab Management**: Selects the correct tab in the `UITabBarController` before performing a transition.
- **Navigation Type**: Supports different navigation types (push, present, root) for greater flexibility.

```swift
public func route(screen identifier: ScreenIdentifier? = nil, source: UIViewController? = nil, navigationType: NavigationType) {
    if let identifier {
        routeHandlers[identifier]?.start(from: source, using: identifier, navigationType: navigationType)
    } else {
        navigate(navigationType: navigationType)
    }
}
```

This structure makes it easy to scale the navigation logic to new tabs or screens without altering the core architecture.

### 2. **DetailRoute**

The `DetailRoute` handles navigation within the **Detail** module, allowing for seamless transitions to sub-detail screens as needed.

```swift
public func routeToSubDetail(from source: UIViewController, dependency: DetailDependency) {
    appRouter?.route(screen: .subDetail(dependency: dependency), source: source, navigationType: .open(type: .push()))
}
```

### 3. **SceneDelegate: Registering the AppRouter**

The **SceneDelegate** is responsible for setting up the app’s navigation structure and registering the `AppRouter`. This ensures that the router manages all screen transitions and persists throughout the app's lifecycle.

```swift
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var appRouter: AppRouter?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let homeNavController = UINavigationController()
        let settingsNavController = UINavigationController()
        let detailNavController = UINavigationController()

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [homeNavController, detailNavController, settingsNavController]

        // Initialize the AppRouter
        appRouter = AppRouter(tabBarController: tabBarController)

        // Register route handlers
        appRouter?.registerRoute(identifier: .home, handler: HomeRoute(navigationController: homeNavController, appRouter: appRouter!))
        appRouter?.registerRoute(identifier: .settings, handler: SettingsRoute(navigationController: settingsNavController, appRouter: appRouter!))
        appRouter?.registerRoute(identifier: .detail(dependency: nil), handler: DetailRoute(navigationController: detailNavController, appRouter: appRouter!))

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}
```

### 4. **Potential Future Extensions**

The architecture in this project is designed to be easily extended for the following navigation types:

#### **Deep Linking** (Future Implementation)
Deep linking allows your app to be opened from URLs, mapping URL schemes to specific screens using the `ScreenIdentifier`.

#### **Push Notifications** (Future Implementation)
Push notifications can trigger navigation to specific screens in the app based on a payload. For example, a push notification could open the detail screen with specific dependencies.

#### **Silent Push Notifications** (Future Implementation)
Silent push notifications are background notifications that trigger background tasks, like data fetching or preparing a screen before the user opens the app.

#### **In-App Push Notifications** (Future Implementation)
In-app notifications prompt the user to navigate to a specific screen while they are already in the app. These notifications can trigger modals, banners, or inline prompts.

## Memory Management

- **Weak References**: View controllers maintain weak references to the `AppRouter` to prevent **retain cycles**.
- **Persistent Router**: The **SceneDelegate** holds a strong reference to the `AppRouter`, ensuring it persists throughout the app's lifecycle and maintains the overall navigation state.

## How to Run

1. Clone the repository or download the project files.
2. Open the project in **Xcode 16**.
3. Select a target device (simulator or real device) and press **Run** (`Cmd + R`).

The app will launch with a tab bar containing **Home**, **Settings**, and **Detail** tabs. You can navigate between these screens by interacting with the buttons.

## How to Navigate

1. **Home Tab**: 
   - From the **Home** tab, click **"Go to Settings"** to switch to the **Settings** tab.
   - Click **"Go to Detail"** to switch to the **Detail** tab.
2. **Settings Tab**:
   - From the **Settings** tab, click **"Go to Detail"** to navigate to the **SettingsDetailController**.
3. **Detail Tab**: 
   - On the **Detail** tab, click **"Go to Sub Detail"** to navigate to the **SubDetailViewController**.
   - You can also manually switch to the **Detail** tab using the tab bar.

## Potential Future Improvements

- **Push Notification Support**: Integrate full push notification handling with routing using `ScreenIdentifier`.
- **Silent Push Background Tasks**: Add background tasks triggered by silent push notifications.
- **Deep Linking Integration**: Implement deep link URL parsing to map URLs to screens in the app.
- **In-App Push Notifications**: Display banners or modals for in-app notifications that allow users to navigate to specific screens.
- **Additional Tabs**: The tab bar controller can easily be extended to include more tabs with their own `UINavigationController` instances.
- **Dynamic Content**: The detail and sub-detail views can be extended to fetch dynamic content based on the passed `DetailDependency`.
- **Deeper Navigation Stacks**: Support for more complex navigation flows within each tab by pushing more view controllers onto the navigation stack.

## Memory Leak Prevention

To avoid memory leaks:
- **View controllers** hold weak references to the `AppRouter`.
- **AppRouter** is only strongly referenced by the **SceneDelegate**, preventing it from being leaked.

## License

This project is licensed under the MIT License.

