//
//  NetworkClient.swift
//  MovieDB
//
//  Created by Christos Home on 22/03/2020.
//  Copyright © 2020 Christos Bimpas. All rights reserved.
//

import Foundation

class NetworkClient: Networking {
    
    // MARK: - Properties
    
    private var baseUrlString = "https://api.themoviedb.org/3/"
    private let cache = URLCache(memoryCapacity: 0, diskCapacity: 100 * 1024 * 1024, diskPath: "MoviewDB")
    private var dataTask: URLSessionDataTask?
    
    lazy var urlSession: URLSession = {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.requestCachePolicy = .returnCacheDataElseLoad
        sessionConfiguration.urlCache = cache
        
        return URLSession(configuration: sessionConfiguration)
    }()
    
    // MARK: - Methods
    
    func getRequest(path: String, completion: @escaping (Result<Data,Error>) -> ()) {
        guard let url = URL(string: baseUrlString + path) else {
            completion(.failure(CustomError.unknownError))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        if let cachedData = cache.cachedResponse(for: urlRequest) {
            completion(.success(cachedData.data))
        } else {
            urlSession.dataTask(with: urlRequest) { [weak self] data, response, error in
                if let error = error {
                    completion(.failure(error))
                } else if let response = response, let data = data {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    self?.cache.storeCachedResponse(cachedData, for: urlRequest)

                    completion(.success(data))
                } else {
                    completion(.failure(CustomError.unknownError))
                }
            }.resume()
        }
    }
}
