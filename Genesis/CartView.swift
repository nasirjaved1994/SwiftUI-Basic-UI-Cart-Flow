//
//  CartView.swift
//  Genesis
//
//  Created by Nasir Javed on 20/09/2024.
//

import SwiftUI


struct CartView: View {
    @ObservedObject var viewModel: StoreViewModel
    
    var body: some View {
        VStack {
            List(viewModel.cartItems) { item in
                HStack {
                    Image(systemName: item.product.imageName)
                        .resizable()
                        .frame(width: 50, height: 50)
                    
                    VStack(alignment: .leading) {
                        Text(item.product.name).font(.headline)
                        Text("Color: \(item.selectedColor)")
                            .font(.subheadline)
                            .foregroundColor(getColorFromString(colorName: item.selectedColor))
                        Text("Quantity: \(item.quantity)").font(.subheadline)
                        Text("$\(item.product.price, specifier: "%.2f") x \(item.quantity)")
                    }
                    Spacer()
                    Text("$\(item.product.price * Double(item.quantity), specifier: "%.2f")")
                }
            }
            
            HStack {
                Spacer()
                Text("Total: $\(viewModel.getTotalCost(), specifier: "%.2f")")
                    .font(.largeTitle)
                    .padding()
            }
        }
        .navigationTitle("Shopping Cart")
    }
    
    // Helper function to map color names to actual SwiftUI colors
    func getColorFromString(colorName: String) -> Color {
        switch colorName {
        case "Red": return .red
        case "Blue": return .blue
        case "Green": return .green
        case "Black": return .black
        case "White": return .white
        default: return .gray
        }
    }
}
