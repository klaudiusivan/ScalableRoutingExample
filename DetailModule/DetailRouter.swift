//
//  DetailRouter.swift
//  DetailModule
//
//  Created by Klaudius Ivan on 10/13/24.
//

import DomainModule
import UIKit

/// A protocol defining the navigation actions for the Detail screen.
public protocol DetailRouter {
    /// Navigate back to the Home screen.
    func backToHome()
    
    func routeToSubDetail(from source: UIViewController, dependency: DetailDependency)
}
