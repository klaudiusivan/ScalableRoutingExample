//
//  HomeRouter.swift
//  HomeModule
//
//  Created by Klaudius Ivan on 10/13/24.
//

import Foundation
import DomainModule

/// A protocol defining the navigation actions for the Home screen.
public protocol HomeRouter {
    /// Navigate to the Settings screen.
    func navigateToSettings()

    /// Navigate to the Detail screen with an optional dependency.
    ///
    /// - Parameter dependency: The `DetailDependency` for the Detail screen. Can be `nil`.
    func navigateToDetail(dependency: DetailDependency?)
}
