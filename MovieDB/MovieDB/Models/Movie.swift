//
//  Movie.swift
//  MovieDB
//
//  Created by Christos Home on 22/03/2020.
//  Copyright © 2020 Christos Bimpas. All rights reserved.
//

import Foundation

struct Movie: Codable, Equatable {
    let id: Int?
    let title: String?
    let releaseDate: String?
    let overview: String?
    let voteAverage: Double?
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case overview
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
    }
    
    static func ==(lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        overview = try container.decodeIfPresent(String.self, forKey: .overview)
        voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
    }
}
