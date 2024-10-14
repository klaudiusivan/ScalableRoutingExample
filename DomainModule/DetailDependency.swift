//
//  DetailDependency.swift
//  DomainModule
//
//  Created by Klaudius Ivan on 10/13/24.
//

import Foundation

/// A model representing details of an item, used for routing to the detail page.
public struct DetailDependency: Decodable {
    /// The ID of the item.
    public let itemID: Int
    /// The name of the item.
    public let itemName: String

    /// Initializes a new instance of `DetailDependency`.
    ///
    /// - Parameters:
    ///   - itemID: The ID of the item.
    ///   - itemName: The name of the item.
    public init(itemID: Int, itemName: String) {
        self.itemID = itemID
        self.itemName = itemName
    }
}
