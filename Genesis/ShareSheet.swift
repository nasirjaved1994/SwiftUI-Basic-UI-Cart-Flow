//
//  ShareSheet.swift
//  Genesis
//
//  Created by Nasir Javed on 30/09/2024.
//


import SwiftUI
import UIKit

struct ShareSheet: UIViewControllerRepresentable {
    var items: [Any] // Data to share, e.g., text, images, URLs
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // No need to update anything here
    }
}
