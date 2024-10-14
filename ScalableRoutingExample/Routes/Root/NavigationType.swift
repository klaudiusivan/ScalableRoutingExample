//
//  NavigationType.swift
//  ScalableRoutingExample
//
//  Created by Klaudius Ivan on 10/14/24.
//


import UIKit

public enum NavigationType: Hashable {
    case open(type: OpenType = .push())
    case close(type: CloseType = .pop())
    
    public enum OpenType {
        // Set a root page from navigation controller
        case root(animated: Bool = true)
        
        // Pushes a new view controller onto the navigation stack
        case push(animated: Bool = true, hidesTabBar: Bool = true, completion: (() -> Void)? = nil)
        
        // Presents a view controller modally with a specified presentation style
        case present(animated: Bool = true, presentationStyle: UIModalPresentationStyle = .automatic, completion: (() -> Void)? = nil)
        
        var rawValue: String {
            switch self {
            case .root: return "root"
            case .push: return "push"
            case .present: return "present"
            }
        }
    }
    
    public enum CloseType {
        
        // Pops the current view controller from the navigation stack
        case pop(animated: Bool = true, completion: (() -> Void)? = nil)
        
        // Dismisses a presented view controller
        case dismiss(animated: Bool = true, completion: (() -> Void)? = nil)
        
        // Pops to a specific view controller in the stack
        case popToViewController(viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil)
        
        // Pops to the root view controller in the stack
        case popToRoot(animated: Bool = true, completion: (() -> Void)? = nil)
        
        var rawValue: String {
            switch self {
            case .pop: return "pop"
            case .dismiss: return "dismiss"
            case .popToViewController: return "popToViewController"
            case .popToRoot: return "popToRoot"
            }
        }
    }
    
    public static func == (lhs: NavigationType, rhs: NavigationType) -> Bool {
        switch (lhs, rhs) {
        case let (.open(lhsType), .open(rhsType)):
            return lhsType.rawValue == rhsType.rawValue
        case let (.close(lhsType), .close(rhsType)):
            return lhsType.rawValue == rhsType.rawValue
        default:
            return false
        }
    }
    
    public func hash(into hasher: inout Hasher) {
        switch self {
        case let .open(type):
            hasher.combine("open_\(type.rawValue)")
        case let .close(type):
            hasher.combine("close_\(type.rawValue)")
        }
    }
}

