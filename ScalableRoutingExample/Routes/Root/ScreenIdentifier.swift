//
//  ScreenIdentifier.swift
//  ScalableRoutingExample
//
//  Created by Klaudius Ivan on 10/14/24.
//

import DomainModule

/// An enumeration representing the available screen identifiers for routing.
public enum ScreenIdentifier: Hashable, Decodable {

    /// The Home screen.
    case home

    /// The Detail screen with an optional dependency.
    case detail(dependency: DetailDependency? = nil)

    /// The Settings screen.
    case settings

    /// The Sub Detail screen with an optional dependency.
    case subDetail(dependency: DetailDependency? = nil)

    /// The Settings Detail screen.
    case settingsDetail

    /// A computed property that returns the string representation of each `ScreenIdentifier`.
    private static var screenMappings: [ScreenIdentifier: String] {
        return [
            .home: "home",
            .detail(dependency: nil): "detail",
            .settings: "settings",
            .subDetail(dependency: nil): "subdetail",
            .settingsDetail: "settingsdetail"
        ]
    }

    /// A computed property to return the string representation for the current `ScreenIdentifier`.
    public var stringValue: String {
        return ScreenIdentifier.screenMappings[self] ?? ""
    }

    /// Initializes a `ScreenIdentifier` from a string.
    ///
    /// - Parameter string: The string representing the screen identifier.
    /// - Returns: A corresponding `ScreenIdentifier` or `nil` if the string is invalid.
    public init?(from string: String) {
        let normalizedString = string.lowercased()
        if let identifier = ScreenIdentifier.screenMappings.first(where: { $0.value == normalizedString })?.key {
            self = identifier
        } else {
            return nil
        }
    }

    /// Custom initializer to decode JSON and map to the correct `ScreenIdentifier`.
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
    private enum CodingKeys: String, CodingKey {
        case screen
        case dependency
    }

    /// Compares two `ScreenIdentifier` values.
    public static func == (lhs: ScreenIdentifier, rhs: ScreenIdentifier) -> Bool {
        return lhs.stringValue == rhs.stringValue
    }

    /// Hashes the `ScreenIdentifier` value.
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.stringValue)
    }
}
