//
//  MovieTests.swift
//  MovieDBTests
//
//  Created by Christos Home on 24/03/2020.
//  Copyright © 2020 Christos Bimpas. All rights reserved.
//

import XCTest
@testable import MovieDB

class MovieTests: XCTestCase {
    
    func test_movie_NotNil() {
        XCTAssertNotNil(ModelFactory.movie1)
    }
    
    func test_Movie_Id() {
        XCTAssertEqual(ModelFactory.movie1!.id, 347754)
    }
    
    func test_Movie_Title() {
        XCTAssertEqual(ModelFactory.movie1!.title, "Curve")
    }
    
    func test_Movie_ReleaseDate() {
        XCTAssertEqual(ModelFactory.movie1!.releaseDate, "2015-08-31")
    }
    
    func test_Movie_Overview() {
        XCTAssertEqual(ModelFactory.movie1!.overview, "A young woman becomes trapped in her car after a hitchhiker causes her to have an automobile accident.")
    }
    
    func test_Movie_VoteAverage() {
        XCTAssertEqual(ModelFactory.movie1!.voteAverage, 7.1)
    }
    
    func test_Movie_PosterPath() {
        XCTAssertEqual(ModelFactory.movie1!.posterPath, "/7ylei4CzaA8XFTir1ocWxVzHWTQ.jpg")
    }
}
