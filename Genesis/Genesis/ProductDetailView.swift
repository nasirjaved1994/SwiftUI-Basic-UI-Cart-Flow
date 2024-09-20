import SwiftUI

struct ProductDetailView: View {
    @ObservedObject var viewModel: StoreViewModel
    var product: Product
    
    @State private var selectedColor: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        VStack {
            Image(systemName: product.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            
            Text(product.name)
                .font(.largeTitle)
                .padding(.top)
            
            Text(product.description)
                .font(.body)
                .padding(.horizontal)
            
            Text("$\(product.price, specifier: "%.2f")")
                .font(.title)
                .padding(.top)
            
            // Color selection
            Text("Choose a color:")
                .font(.headline)
                .padding(.top)
            
            // Color Swatches
            HStack {
                ForEach(product.availableColors, id: \.self) { color in
                    ColorCircle(colorName: color, isSelected: selectedColor == color)
                        .onTapGesture {
                            selectedColor = color
                        }
                }
            }
            .padding(.horizontal)
            
            // Add to Cart Button
            Button(action: {
                if selectedColor.isEmpty {
                    alertMessage = "Please select a color before adding to the cart."
                    showAlert = true
                } else {
                    let added = viewModel.addToCart(product: product, selectedColor: selectedColor)
                    if added {
                        alertMessage = "Product added to cart successfully!"
                    } else {
                        alertMessage = "This product is already added to the cart with the selected color."
                    }
                    showAlert = true
                }
            }) {
                Text("Add to Cart")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top)
            
            Spacer()
        }
        .padding()
        .navigationTitle(product.name)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Cart"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

struct ColorCircle: View {
    let colorName: String
    let isSelected: Bool
    
    var body: some View {
        Circle()
            .fill(getColorFromString(colorName: colorName))
            .frame(width: 40, height: 40)
            .overlay(
                Circle()
                    .stroke(isSelected ? Color.black : Color.clear, lineWidth: 2)
            )
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
