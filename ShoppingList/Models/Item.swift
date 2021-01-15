//
//  Item.swift
//  ShoppingList
//
//  Created by stanley phillips on 1/15/21.
//

import Foundation

class Item: Codable {
    let name: String
    var isPurchased: Bool
    var quantity: Int?
    
    init(name: String, isPurchased: Bool = false, quantity: Int? = 1) {
        self.name = name
        self.isPurchased = isPurchased
        self.quantity = quantity
    }
}

extension Item: Equatable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name && lhs.isPurchased == rhs.isPurchased && lhs.quantity == rhs.quantity
    }
}
