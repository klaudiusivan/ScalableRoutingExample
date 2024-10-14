//
//  ScreenIdentifier.swift
//  ScalableRoutingExample
//
//  Created by Klaudius Ivan on 10/14/24.
//

import DomainModule

/// An enumeration representing the available screen identifiers for routing.
///
/// This enum is used to identify different screens in the application and
/// manage navigation across the app. It supports encoding and decoding
/// for JSON-based navigation and provides associated values for screens
/// that require dependencies.
public enum ScreenIdentifier: Hashable, Decodable, CaseIterable {
    
    /// A list of all possible `ScreenIdentifier` cases.
    ///
    /// This is required because `ScreenIdentifier` contains cases with associated values.
    /// The associated values (such as dependencies) are set to `nil` by default to ensure
    /// that the enum can still conform to `CaseIterable`.
    public static var allCases: [ScreenIdentifier] = [
        .home,
        .detail(),
        .settings,
        .subDetail(),
        .settingsDetail
    ]
    
    /// The Home screen.
    case home

    /// The Detail screen with an optional dependency.
    ///
    /// - Parameter dependency: An optional `DetailDependency` object that provides data to be displayed on the detail screen.
    case detail(dependency: DetailDependency? = nil)

    /// The Settings screen.
    case settings

    /// The Sub Detail screen with an optional dependency.
    ///
    /// - Parameter dependency: An optional `DetailDependency` object for the sub-detail screen.
    case subDetail(dependency: DetailDependency? = nil)

    /// The Settings Detail screen.
    case settingsDetail

    /// A computed property to return the string representation for the current `ScreenIdentifier`.
    ///
    /// This string value is useful for mapping `ScreenIdentifier` to a string for external systems,
    /// such as JSON-based navigation, push notifications, or deep linking.
    public var stringValue: String {
        switch self {
        case .home: return "home"
        case .detail(_): return "detail"
        case .settings: return "settings"
        case .subDetail(_): return "subDetail"
        case .settingsDetail: return "settingsDetail"
        }
    }

    /// Initializes a `ScreenIdentifier` from a string.
    ///
    /// This initializer takes a string and attempts to map it to a `ScreenIdentifier`.
    /// If the string does not match any of the available cases, the initializer returns `nil`.
    ///
    /// - Parameter string: The string representation of a `ScreenIdentifier`.
    public init?(from string: String) {
        if let notifIdentifier = ScreenIdentifier.allCases.first(where: { $0.stringValue == string }) {
            self = notifIdentifier
        } else {
            return nil
        }
    }

    /// Custom initializer to decode JSON and map to the correct `ScreenIdentifier`.
    ///
    /// This initializer decodes the "screen" and "dependency" fields from the JSON and uses them
    /// to initialize the appropriate `ScreenIdentifier`. If a dependency is present in the JSON,
    /// it is also decoded and assigned to the appropriate case.
    ///
    /// - Parameter decoder: The decoder used to parse the JSON data.
    /// - Throws: `DecodingError` if the JSON structure is invalid or the screen identifier is not recognized.
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let screen = try container.decode(String.self, forKey: .screen)

        if let identifier = ScreenIdentifier(from: screen) {
            switch identifier {
            case .detail:
                let dependency = try? container.decode(DetailDependency.self, forKey: .dependency)
                self = .detail(dependency: dependency)
            case .subDetail:
                let dependency = try? container.decode(DetailDependency.self, forKey: .dependency)
                self = .subDetail(dependency: dependency)
            default:
                self = identifier
            }
        } else {
            throw DecodingError.dataCorruptedError(forKey: .screen, in: container, debugDescription: "Unknown screen value")
        }
    }

    /// CodingKeys to define the keys in the JSON.
    ///
    /// The "screen" field is used to decode the screen identifier string.
    /// The "dependency" field is used to decode the optional dependency for screens that require it.
    private enum CodingKeys: String, CodingKey {
        case screen
        case dependency
    }

    /// Compares two `ScreenIdentifier` values for equality.
    ///
    /// This function compares the `stringValue` of both `ScreenIdentifier` instances to check for equality.
    public static func == (lhs: ScreenIdentifier, rhs: ScreenIdentifier) -> Bool {
        return lhs.stringValue == rhs.stringValue
    }

    /// Hashes the `ScreenIdentifier` value.
    ///
    /// This function hashes the `stringValue` of the `ScreenIdentifier` to generate a unique hash.
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.stringValue)
    }
}
