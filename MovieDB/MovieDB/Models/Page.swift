//
//  Page.swift
//  MovieDB
//
//  Created by Christos Home on 22/03/2020.
//  Copyright © 2020 Christos Bimpas. All rights reserved.
//

import UIKit

struct Page: Codable, Equatable {
    let pageNumber: Int?
    let totalPages: Int?
    let results: [Movie]?
    
    enum CodingKeys: String, CodingKey {
        case pageNumber = "page"
        case totalPages = "total_pages"
        case results
    }
    
    static func ==(lhs: Page, rhs: Page) -> Bool {
        return lhs.pageNumber == rhs.pageNumber &&
            lhs.totalPages == rhs.totalPages &&
            lhs.results == rhs.results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        pageNumber = try container.decode(Int.self, forKey: .pageNumber)
        totalPages = try container.decode(Int.self, forKey: .totalPages)
        results = try container.decodeIfPresent([Movie].self, forKey: .results)
    }
}
