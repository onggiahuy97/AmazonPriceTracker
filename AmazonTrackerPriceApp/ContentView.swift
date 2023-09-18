//
//  ContentView.swift
//  AmazonTrackerPriceApp
//
//  Created by Huy Ong on 9/16/23.
//

import SwiftUI

struct ContentView: View {
    @State private var products: [AmazonProduct] = []
    @State private var productId: String = "B07ZPKN6YR"
    @State private var isFetching = false
    
    var body: some View {
        VStack {
            HStack {
                TextField("Product ID", text: $productId)
                    .textFieldStyle(.roundedBorder)
                Button("Fetch") {
                    callRequest()
                }
                .disabled(productId.isEmpty)
            }
            
            ScrollView {
                ForEach(products) { product in
                    ProductCellView(product: product)
                }
                
                if isFetching {
                    ProgressView()
                }
            }
        }
        .padding()
        
    }
    
    private func callRequest() {
        self.isFetching = true

        NetworkManager.shared.fetchProductById(productId) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let product):
                DispatchQueue.main.async {
                    if !self.products.contains(where: { $0.id == product.id }) {
                        self.products.append(product)
                    }
                }
            }
            
            self.isFetching = false
        }
    }
}

#Preview {
    ContentView()
}
