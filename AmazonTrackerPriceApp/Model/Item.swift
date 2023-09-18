//
//  Item.swift
//  AmazonTrackerPriceApp
//
//  Created by Huy Ong on 9/17/23.
//

import SwiftData
import Foundation

@Model
final class Product {
    var productID: String
    var title: String
    var imageUrl: String
    var prices: [Price] = []
    
    init(productID: String, title: String, imageUrl: String) {
        self.productID = productID
        self.title = title
        self.imageUrl = imageUrl
    }
}

@Model
final class Price {
    var price: String
    var date: Date
    
    init(price: String, date: Date = Date()) {
        self.price = price
        self.date = date
    }
}
