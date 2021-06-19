//
//  NetworkManager.swift
//  BitbucketPublicProject
//
//  Created by Khant Zaw Win on 19/6/21.
//

import Foundation
import UIKit

final class NetworkManager{
    
    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()
    
    static let baseURL = "https://api.bitbucket.org/2.0/repositories"
    
    private init() {}
    
    func getRepositories(fromURLString urlString: String, completed: @escaping (Result<RepositoryResponse, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(RepositoryResponse.self, from: data)
                completed(.success(decodedResponse))
            } catch{
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func downloadImage(fromURLString urlString: String, completed: @escaping (_ image: UIImage?) -> Void){
        
        let cacheKey = NSString(string: urlString)

        if let image = cache.object(forKey: cacheKey){
            completed(image)
            return
        }

        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            guard let data = data, let image = UIImage(data: data) else{
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
}
