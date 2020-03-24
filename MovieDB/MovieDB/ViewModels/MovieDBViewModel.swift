//
//  MovieDBViewModel.swift
//  MovieDB
//
//  Created by Christos Home on 22/03/2020.
//  Copyright © 2020 Christos Bimpas. All rights reserved.
//

import UIKit

class MovieDBViewModel {
    
    typealias CompletionBlock = (Result<Void,Error>) -> ()
    typealias VoidCompletionBlock = () -> Void
    
    // MARK: - API KEY
    
    //You can get your api key here https://developers.themoviedb.org/3/getting-started/introduction
    
    var apiKey: String? = nil
    
    // MARK: - Constants
    
    let collectionViewPadding: CGFloat = 10
    let title = "Popular Movies"
    
    let collectionViewFooterHeight: CGFloat = 80
    let path = "movie/popular"
    private let initialPage = 1
    
    // MARK: - Properties
    
    let networkClient: Networking
    private var completionBlock: CompletionBlock?
    private var fetchedAllPagesCompletionBlock: VoidCompletionBlock?
    private var noApiKeyCompletionBlock: VoidCompletionBlock?
    var didFetchAllPages = false
    
    var page: Page? {
        didSet {
            guard let pageResults = page?.results else { return }
            movies.append(contentsOf: pageResults)
        }
    }
    
    var movies = [Movie]()
    
    // MARK: - Computed Properties
    
    var numberOfItems: Int {
        return movies.count
    }
    
    var shouldFetchData: Bool {
        return numberOfItems > 0 && !didFetchAllPages
    }
    
    var nextPageNumber: Int? {
        var pageNumber = initialPage
        
        guard let page = page,
            let currentPageNumber = page.pageNumber,
            let currentTotalPages = page.totalPages else {
                return pageNumber
        }
        
        pageNumber = currentPageNumber + 1
        
        guard pageNumber <= currentTotalPages else {
            return nil
        }
        
        return pageNumber
    }
    
    var shouldHideFooter: Bool {
        return didFetchAllPages || apiKey == nil
    }
    
    // MARK: - Init
    
    init(networkClient: Networking) {
        self.networkClient = networkClient
    }
    
    // MARK: - Public methods
    
    // MARK: Data
    
    func fetchData() {
        guard let pageNumber = nextPageNumber else {
            didFetchAllPages = true
            fetchedAllPagesCompletionBlock?()
            return
        }
        
        guard let apiKey = apiKey else {
            noApiKeyCompletionBlock?()
            return
        }
        
        let fullPath = path(for: apiKey, and: pageNumber)
        
        networkClient.getRequest(path: fullPath) { [weak self] result in
            switch result {
            case .success(let data):
                self?.decodePage(from: data)
            case .failure(let error):
                self?.completionBlock?(.failure(error))
            }
        }
    }
    
    func decodePage(from data: Data) {
        do {
            page = try JSONDecoder().decode(Page.self, from: data)
            completionBlock?(.success(()))
        }
        catch {
            completionBlock?(.failure(error))
        }
    }
   
    func movieModel(at index: Int) -> MovieViewModel? {
        guard let movie = movies[safe: index] else { return nil }
        
        return MovieViewModel(movie: movie)
    }
    
    func path(for apiKey: String, and pageNumber: Int) -> String {
        return path + "?api_key=\(apiKey)&page=\(pageNumber)"
    }
    
    // MARK: Sizes
    
    func itemSizeInView(with frame: CGRect) -> CGSize {
        return CGSize(width: frame.width - collectionViewPadding * 2, height: frame.width * 2.0 / 3.0)
    }
    
    func headerSizeInView(with frame: CGRect) -> CGSize {
        return CGSize(width: frame.width, height: collectionViewPadding)
    }
    
    func footerSizeInView(with frame: CGRect) -> CGSize {
        return CGSize(width: frame.width, height: shouldHideFooter ? 0 : collectionViewFooterHeight)
    }
    
    // MARK: - Observers
    
    func observeFetchCompletion(_ block: @escaping CompletionBlock) {
        completionBlock = block
    }
    
    func observeFetchedAllPagesCompletion(_ block: @escaping VoidCompletionBlock) {
        fetchedAllPagesCompletionBlock = block
    }
    
    func observeNoApiKeyCompletion(_ block: @escaping VoidCompletionBlock) {
        noApiKeyCompletionBlock = block
    }
}
