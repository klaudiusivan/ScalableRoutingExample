//
//  Route.swift
//  ScalableRoutingExample
//
//  Created by Klaudius Ivan on 10/13/24.
//

import UIKit

public protocol Route {
    /// Start the route from a given source with a completion handler.
    /// - Parameters:
    ///   - source: The source from where the route starts (e.g., a UIViewController or any other entity).
    ///   - completion: A closure to be executed upon route completion, allowing the caller to handle post-route actions.
    ///   - identifier: The screen identifier to register.
    mutating func start(from source: UIViewController?, using identifier: ScreenIdentifier, navigationType: NavigationType)
}

