//
//  Networking.swift
//  MovieDB
//
//  Created by Christos Home on 22/03/2020.
//  Copyright © 2020 Christos Bimpas. All rights reserved.
//

import Foundation

protocol Networking {
    func getRequest(path: String, completion: @escaping (Result<Data,Error>) -> ())
}

