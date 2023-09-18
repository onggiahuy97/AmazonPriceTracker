//
//  ProductCellView.swift
//  AmazonTrackerPriceApp
//
//  Created by Huy Ong on 9/18/23.
//

import SwiftUI

struct ProductCellView: View {
    var product: AmazonProduct
    
    var cell: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: product.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 2)
                    .clipShape(.rect(cornerRadius: 8))
                
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)

            
            VStack(alignment: .leading) {
                Text(product.productTitle)
                    .font(.headline)
                    .bold()
                
                Spacer()
                
                HStack {
                    Text(product.productId)
                        .foregroundStyle(.secondary)
                        .dynamicTypeSize(.small)
                        .italic()
                    
                    Spacer()
                    Text("$\(product.price)")
                }
                
                Divider()
            }
        }
        .frame(height: 100)
        .padding(.bottom)
    }
    
    var body: some View {
        Button {
            if let url = URL(string: "https://amazon.com/dp/\(product.id)") {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }
        } label: {
            cell
        }
        .buttonStyle(.plain)
    }
}

//#Preview {
//    ProductCellView()
//}
