//
//  ModelFactory.swift
//  MovieDBTests
//
//  Created by Christos Home on 24/03/2020.
//  Copyright © 2020 Christos Bimpas. All rights reserved.
//

import Foundation
@testable import MovieDB

struct ModelFactory {
    enum JSON: String {
        case page1
        case page2
        case page500
        case movie1
        case movie2
        case movie3
        case movie4
    }
    
    static var page1: Page? = decodableModel(from: JSON.page1.rawValue)
    static var page2: Page? = decodableModel(from: JSON.page2.rawValue)
    static var page500: Page? = decodableModel(from: JSON.page500.rawValue)
    static var movie1: Movie? = decodableModel(from: JSON.movie1.rawValue)
    static var movie2: Movie? = decodableModel(from: JSON.movie2.rawValue)
    static var movie3: Movie? = decodableModel(from: JSON.movie3.rawValue)
    static var movie4: Movie? = decodableModel(from: JSON.movie4.rawValue)

    private static func decodableModel<D: Decodable>(from resourcePath: String) -> D? {
        guard let data = jsonData(from: resourcePath) else { return nil }
        return try? JSONDecoder().decode(D.self, from: data)
    }

    static func jsonData(from resourcePath: String) -> Data? {
        guard let bundlePath = Bundle(for: MockNetworkingClient.self)
            .url(forResource: resourcePath, withExtension: "json") else { fatalError("\(resourcePath).json not found") }
        
        return try? Data(contentsOf: bundlePath, options: .mappedIfSafe)
    }
}
