//
//  ProductListView.swift
//  Genesis
//
//  Created by Nasir Javed on 20/09/2024.
//



import SwiftUI

struct ProductListView: View {
    @ObservedObject var viewModel: StoreViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.products) { product in
                NavigationLink(destination: ProductDetailView(viewModel: viewModel, product: product)) {
                    HStack {
                        Image(systemName: product.imageName)
                            .resizable()
                            .frame(width: 50, height: 50)
                        VStack(alignment: .leading) {
                            Text(product.name).font(.headline)
                            Text("$\(product.price, specifier: "%.2f")").font(.subheadline)
                        }
                    }
                }
            }
            .navigationTitle("Products")
            .navigationBarItems(trailing: cartButton)
        }
    }
    
    // Cart button with badge
    private var cartButton: some View {
        ZStack {
            NavigationLink(destination: CartView(viewModel: viewModel)) {
                Image(systemName: "cart")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            
            // Badge for the cart item count
            if viewModel.cartItems.count > 0 {
                ZStack {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 16, height: 16)
                    
                    Text("\(viewModel.cartItems.count)")
                        .font(.caption)
                        .foregroundColor(.white)
                }
                .offset(x: 10, y: -10)
            }
        }
    }
}
