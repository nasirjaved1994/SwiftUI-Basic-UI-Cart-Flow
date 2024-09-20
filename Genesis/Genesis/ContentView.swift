//
//  ContentView.swift
//  Genesis
//
//  Created by Nasir Javed on 20/09/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = StoreViewModel()
    
    var body: some View {
        ProductListView(viewModel: viewModel)
    }
}

#Preview {
    ContentView()
}
