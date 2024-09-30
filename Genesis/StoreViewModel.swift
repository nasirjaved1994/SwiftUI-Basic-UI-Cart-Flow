//
//  Untitled.swift
//  Genesis
//
//  Created by Nasir Javed on 20/09/2024.
//

import SwiftUI




class StoreViewModel: ObservableObject {
    @Published var products: [Product] = [
        Product(name: "Laptop", price: 1200.0, description: "A powerful laptop for work and play with top-notch performance.", imageName: "laptopcomputer", availableColors: ["Red", "Green", "Black"]),
        Product(name: "Phone", price: 800.0, description: "A sleek smartphone with the latest features for communication, entertainment, and productivity.", imageName: "iphone", availableColors: ["Black", "Red", "Blue"]),
        Product(name: "Headphones", price: 200.0, description: "Noise-cancelling wireless headphones with superior sound quality.", imageName: "headphones", availableColors: ["Black", "Blue"])
    ]
    
    @Published var cartItems: [CartItem] = []
    
    @Published var favItem: [Product] = []
    
    func addToCart(product: Product, selectedColor: String) -> Bool {
        if let index = cartItems.firstIndex(where: { $0.product.id == product.id && $0.selectedColor == selectedColor }) {
            // Product with same color already exists in cart
            return false
        } else {
            let newCartItem = CartItem(product: product, quantity: 1, selectedColor: selectedColor)
            cartItems.append(newCartItem)
            return true
        }
    }
    
    func getTotalCost() -> Double {
        cartItems.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
    }
}
