//
//  Product.swift
//  Genesis
//
//  Created by Nasir Javed on 20/09/2024.
//

import Foundation

struct Product: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
    let description: String
    let imageName: String
    let availableColors: [String] // New field for available colors
}


struct CartItem: Identifiable {
    let id = UUID()
    let product: Product
    var quantity: Int
    let selectedColor: String // New field for selected color
}
