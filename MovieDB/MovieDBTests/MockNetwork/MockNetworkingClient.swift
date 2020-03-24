//
//  MockNetworkingClient.swift
//  MovieDBTests
//
//  Created by Christos Home on 24/03/2020.
//  Copyright © 2020 Christos Bimpas. All rights reserved.
//

import Foundation
@testable import MovieDB

class MockNetworkingClient: Networking {
    
    var successMode = true
    var data = Data()
    
    func getRequest(path: String, completion: @escaping (Result<Data, Error>) -> ()) {
        guard successMode else {
            completion(.failure(CustomError.unknownError))
            return
        }
        completion(.success(data))
    }
}
