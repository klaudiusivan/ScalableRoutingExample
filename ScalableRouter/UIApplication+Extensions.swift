//
//  func.swift
//  ScalableRoutingExample
//
//  Created by Klaudius Ivan on 10/14/24.
//


import UIKit

extension UIApplication {
    
    func topMostViewController(base: UIViewController? = UIApplication.shared.connectedScenes
                                        .filter { $0.activationState == .foregroundActive }
                                        .compactMap { ($0 as? UIWindowScene)?.keyWindow }
                                        .first?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topMostViewController(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topMostViewController(base: selected)
            }
        }
        
        if let presented = base?.presentedViewController {
            return topMostViewController(base: presented)
        }
        
        return base
    }
}
