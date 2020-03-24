//
//  PageTests.swift
//  MovieDBTests
//
//  Created by Christos Home on 24/03/2020.
//  Copyright © 2020 Christos Bimpas. All rights reserved.
//

import XCTest
@testable import MovieDB

class PageTests: XCTestCase {

    func test_page1_NotNil() {
        XCTAssertNotNil(ModelFactory.page1)
    }
    
    func test_page2_NotNil() {
        XCTAssertNotNil(ModelFactory.page2)
    }
    
    func test_page500_NotNil() {
        XCTAssertNotNil(ModelFactory.page500)
    }
    
    func test_Page_PageNumber() {
        XCTAssertEqual(ModelFactory.page1!.pageNumber, 1)
    }
    
    func test_Page_TotalPages() {
        XCTAssertEqual(ModelFactory.page1!.totalPages, 500)
    }
}
