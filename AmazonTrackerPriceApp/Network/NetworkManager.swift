//
//  NetworkManager.swift
//  AmazonTrackerPriceApp
//
//  Created by Huy Ong on 9/17/23.
//

import Foundation

struct AmazonProduct: Decodable, Identifiable {
    var id: String { productId }
    var productId: String
    var price: String
    var productTitle: String
    var imageUrl: String
}

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidData
    case decodingFailed(Error)
}

class NetworkManager {
    static let shared = NetworkManager()
    static let baseURL = "http://localhost:3000/api"
    
    func fetchProduct(_ urlString: String, completion: @escaping (Result<AmazonProduct, NetworkError>) -> Void) {
        guard let url = generateProductURL(urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        fetchGeneric(url, completion: completion)
    }
    
    func fetchProductById(_ productId: String, completion: @escaping (Result<AmazonProduct, NetworkError>) -> Void) {
        guard let url = URL(string: Self.baseURL)?.appending(path: productId) else {
            completion(.failure(.invalidURL))
            return
        }
        
        fetchGeneric(url, completion: completion)
    }
    
    private func generateProductURL(_ urlString: String) -> URL? {
        var components = URLComponents(string: Self.baseURL)
        components?.queryItems = [
            URLQueryItem(name: "url", value: urlString)
        ]
        
        guard let url = components?.url else {
            return nil
        }
        
        return url
    }
    
//    private func fetchGeneric<T: Decodable>(_ urlString: String, completion: @escaping (Result<T, NetworkError>) -> Void) { 
//        guard let url = URL(string: urlString) else {
//            completion(.failure(.invalidURL))
//            return
//        }
//        
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            if let error {
//                completion(.failure(.requestFailed(error)))
//                return
//            }
//            
//            guard let data else {
//                completion(.failure(.invalidData))
//                return
//            }
//            
//            do {
//                let decodedData = try JSONDecoder().decode(T.self, from: data)
//                completion(.success(decodedData))
//            } catch {
//                completion(.failure(.decodingFailed(error)))
//            }
//        }
//        .resume()
//    }
    
    private func fetchGeneric<T: Decodable>(_ url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingFailed(error)))
            }
        }
        .resume()
        
    }
}
