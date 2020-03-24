//
//  MovieDBViewModelTests.swift
//  MovieDBTests
//
//  Created by Christos Home on 24/03/2020.
//  Copyright © 2020 Christos Bimpas. All rights reserved.
//

import XCTest
@testable import MovieDB

class MovieDBViewModelTests: XCTestCase {

    var viewModel: MovieDBViewModel!
    let mockedNetworkingClient = MockNetworkingClient()
    
    override func setUp() {
        viewModel = MovieDBViewModel(networkClient: mockedNetworkingClient)
    }

    override func tearDown() {
        viewModel = nil
    }

    
    func test_NumberOfItems() {
        viewModel.movies = [ModelFactory.movie1, ModelFactory.movie2].compactMap { $0 }
        XCTAssertEqual(viewModel.numberOfItems, viewModel.movies.count)
    }
    
    func test_shouldFetchData_True() {
        viewModel.movies = [ModelFactory.movie3, ModelFactory.movie4].compactMap { $0 }
        viewModel.didFetchAllPages = false
        XCTAssertEqual(viewModel.shouldFetchData, true)
    }
    
    func test_shouldFetchData_ZeroMovies_False() {
        viewModel.movies = []
        viewModel.didFetchAllPages = false
        XCTAssertEqual(viewModel.shouldFetchData, false)
    }
    
    func test_shouldFetchData_AllPagesFetched_False() {
        viewModel.movies = [ModelFactory.movie1, ModelFactory.movie3].compactMap { $0 }
        viewModel.didFetchAllPages = true
        XCTAssertEqual(viewModel.shouldFetchData, false)
    }
    
    func test_shouldFetchData_ZeroMovies_AllPagesFetched_False() {
        viewModel.movies = []
        viewModel.didFetchAllPages = true
        XCTAssertEqual(viewModel.shouldFetchData, false)
    }
    
    func test_nextPageNumber_currentIsOne() {
        viewModel.page = ModelFactory.page1
        XCTAssertEqual(viewModel.nextPageNumber, 2)
    }
    
    func test_nextPageNumber_currentIsTwo() {
        viewModel.page = ModelFactory.page2
        XCTAssertEqual(viewModel.nextPageNumber, 3)
    }
    
    func test_nextPageNumber_currentIs500() {
        viewModel.page = ModelFactory.page500
        XCTAssertNil(viewModel.nextPageNumber)
    }
    
    func test_shouldHideFooter_DidFetchAllPages() {
        viewModel.didFetchAllPages = true
        XCTAssertEqual(viewModel.shouldHideFooter, true)
    }
    
    func test_shouldHideFooter_ApiKeyInNil() {
        viewModel.apiKey = nil
        XCTAssertEqual(viewModel.shouldHideFooter, true)
    }
    
    func test_shouldShowFooter_ApiKeyIsNotNil_DidNotFetchAllPages_PageNotNil() {
        viewModel.apiKey = "api key"
        viewModel.didFetchAllPages = false
        viewModel.page = ModelFactory.page1
        XCTAssertEqual(viewModel.shouldHideFooter, false)
    }
    
    func test_FetchData_AfterLastPage() {
        let fetchAllPagesExpectation = expectation(description: "did fetch all pages")
        viewModel.page = ModelFactory.page500
        viewModel.didFetchAllPages = false
        viewModel.observeFetchedAllPagesCompletion {
            fetchAllPagesExpectation.fulfill()
        }
        viewModel.fetchData()
        wait(for: [fetchAllPagesExpectation], timeout: 5)
        XCTAssertEqual(viewModel.didFetchAllPages, true)
    }
    
    func test_FetchData_WithoutApiKey() {
        let noApiKeyExpectation = expectation(description: "did call no api key completion block")
        viewModel.page = ModelFactory.page1
        viewModel.apiKey = nil
        viewModel.observeNoApiKeyCompletion {
            noApiKeyExpectation.fulfill()
        }
        viewModel.fetchData()
        wait(for: [noApiKeyExpectation], timeout: 5)
        XCTAssert(true)
    }
    
    func test_FetchData_Success() {
        let successExpectation = expectation(description: "did fetch data with success")
        viewModel.page = ModelFactory.page1
        mockedNetworkingClient.successMode = true
        mockedNetworkingClient.data = ModelFactory.jsonData(from: ModelFactory.JSON.page1.rawValue)!
        viewModel.observeFetchCompletion { (result) in
            switch result {
                case .success():
                    successExpectation.fulfill()
                case .failure(_):
                    break
                }
        }
        viewModel.fetchData()
        wait(for: [successExpectation], timeout: 5)
        XCTAssert(true)
    }
    
    func test_FetchData_Error() {
        let errorExpectation = expectation(description: "did fetch data with error")
        viewModel.page = ModelFactory.page1
        mockedNetworkingClient.successMode = false
        viewModel.observeFetchCompletion { (result) in
            switch result {
                case .success():
                    break
                case .failure(_):
                    errorExpectation.fulfill()
            }
        }
        viewModel.fetchData()
        wait(for: [errorExpectation], timeout: 5)
        XCTAssert(true)
    }
    
    func test_DecodePageFromData_Success() {
        let decodePageWithSuccessExpectation = expectation(description: "did decode page with success")
        viewModel.observeFetchCompletion { (result) in
            switch result {
                case .success():
                    decodePageWithSuccessExpectation.fulfill()
                case .failure(_):
                    break
            }
        }
        viewModel.decodePage(from: ModelFactory.jsonData(from: ModelFactory.JSON.page1.rawValue)!)
        wait(for: [decodePageWithSuccessExpectation], timeout: 5)
        XCTAssert(true)
    }
    
    func test_DecodePageFromData_Error() {
        let decodePageWithErrorExpectation = expectation(description: "did decode page with error")
        viewModel.observeFetchCompletion { (result) in
            switch result {
                case .success():
                    break
                case .failure(_):
                    decodePageWithErrorExpectation.fulfill()
            }
        }
        viewModel.decodePage(from: ModelFactory.jsonData(from: ModelFactory.JSON.movie1.rawValue)!)
        wait(for: [decodePageWithErrorExpectation], timeout: 5)
        XCTAssert(true)
    }
    
    func test_movieModelIndex_AtIndexZero() {
        viewModel.movies = [ModelFactory.movie1, ModelFactory.movie2, ModelFactory.movie3, ModelFactory.movie4].compactMap { $0 }
        let movieViewModel = viewModel.movieModel(at: 0)
        XCTAssertEqual(movieViewModel?.movie, ModelFactory.movie1)
    }
    
    func test_movieModelIndex_AtIndexOne() {
        viewModel.movies = [ModelFactory.movie1, ModelFactory.movie2, ModelFactory.movie3, ModelFactory.movie4].compactMap { $0 }
        let movieViewModel = viewModel.movieModel(at: 1)
        XCTAssertEqual(movieViewModel?.movie, ModelFactory.movie2)
    }
    
    func test_movieModelIndex_AtWrongIndex() {
        viewModel.movies = [ModelFactory.movie1, ModelFactory.movie2, ModelFactory.movie3, ModelFactory.movie4].compactMap { $0 }
        let movieViewModel = viewModel.movieModel(at: 1000)
        XCTAssertNil(movieViewModel)
    }
    
    func test_fullPath() {
        let apiKey = "api key"
        let pageNumber = 5
        let path = viewModel.path(for: apiKey, and: pageNumber)
        XCTAssertEqual(path, viewModel.path + "?api_key=\(apiKey)&page=\(pageNumber)")
    }
    
    func test_itemSizeInView() {
        let itemSize = viewModel.itemSizeInView(with: CGRect(x: 0, y: 0, width: 100, height: 300))
        XCTAssertEqual(itemSize.width, 100 - viewModel.collectionViewPadding * 2)
        XCTAssertEqual(itemSize.height, 100 * 2.0 / 3.0)
    }
    
    func test_headerSizeInView()  {
        let headerSize = viewModel.headerSizeInView(with: CGRect(x: 0, y: 0, width: 100, height: 300))
        XCTAssertEqual(headerSize.width, 100)
        XCTAssertEqual(headerSize.height, viewModel.collectionViewPadding)
    }
    
    func test_footerSizeInView_ShouldHideFooter() {
        viewModel.apiKey = nil
        let footerSize = viewModel.footerSizeInView(with: CGRect(x: 0, y: 0, width: 100, height: 300))
        XCTAssertEqual(footerSize.width, 100)
        XCTAssertEqual(footerSize.height, 0)
    }
    
    func test_footerSizeInView_ShouldShowFooter() {
        viewModel.apiKey = "api key"
        viewModel.didFetchAllPages = false
        let footerSize = viewModel.footerSizeInView(with: CGRect(x: 0, y: 0, width: 100, height: 300))
        XCTAssertEqual(footerSize.width, 100)
        XCTAssertEqual(footerSize.height, viewModel.collectionViewFooterHeight)
    }
}
