//
//  defining.swift
//  ScalableRoutingExample
//
//  Created by Klaudius Ivan on 10/13/24.
//


import DomainModule

/// A protocol defining the navigation actions for the Settings screen.
public protocol SettingsRouter {
    /// Navigate to the Detail screen with an optional dependency.
    ///
    /// - Parameter dependency: The `DetailDependency` for the Detail screen. Can be `nil`.
    func navigateToDetail(dependency: DetailDependency?)
}
