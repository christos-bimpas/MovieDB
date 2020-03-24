//
//  MovieViewModelTests.swift
//  MovieDBTests
//
//  Created by Christos Home on 24/03/2020.
//  Copyright © 2020 Christos Bimpas. All rights reserved.
//

import XCTest
@testable import MovieDB

class MovieViewModelTests: XCTestCase {

    var viewModel: MovieViewModel!
    
    override func setUp() {
        viewModel = MovieViewModel(movie: ModelFactory.movie1!)
    }

    override func tearDown() {
        viewModel = nil
    }
    
    func test_Title() {
        XCTAssertEqual(viewModel.title, ModelFactory.movie1!.title)
    }
    
    func test_releaseDate() {
        let dateFormatterInput = DateFormatter()
        dateFormatterInput.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.dateFormat = "MMMM dd, yyyy"
        
        let formattedDate = dateFormatterInput.date(from: ModelFactory.movie1!.releaseDate!)
        XCTAssertEqual(viewModel.releaseDate, dateFormatterOutput.string(from: formattedDate!))
    }
    
    func test_posterURL() {
        XCTAssertEqual(viewModel.posterURL,  URL(string: "http://image.tmdb.org/t/p/w500/\(ModelFactory.movie1!.posterPath!)"))
    }
    
    func test_Overview() {
        XCTAssertEqual(viewModel.overview, ModelFactory.movie1!.overview)
    }
    
    func test_VoteAverage() {
        XCTAssertEqual(viewModel.voteAverage, String(viewModel.voteAveragePercent!) + "%")
    }
    
    func test_VoteAverage_Color_Green() {
        viewModel = MovieViewModel(movie: ModelFactory.movie1!)
        XCTAssertEqual(viewModel.voteAverageTextColor, .green)
    }
    
    func test_VoteAverage_Color_Orange() {
        viewModel = MovieViewModel(movie: ModelFactory.movie2!)
        XCTAssertEqual(viewModel.voteAverageTextColor, .orange)
    }
    
    func test_VoteAverage_Color_Red() {
        viewModel = MovieViewModel(movie: ModelFactory.movie3!)
        XCTAssertEqual(viewModel.voteAverageTextColor, .red)
    }
}
