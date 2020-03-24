//
//  LottieExtensionsTests.swift
//  MovieDBTests
//
//  Created by Christos Home on 24/03/2020.
//  Copyright © 2020 Christos Bimpas. All rights reserved.
//

import XCTest
@testable import MovieDB
@testable import Lottie

class LottieExtensionTests: XCTestCase {

    func test_LottieVideoCamAnimationViewView_NotNil() {
        XCTAssertNotNil(LOTAnimationView.videoCamAnimationView)
    }
    
    func test_LottieInfiniteLoaderAnimationView_NotNil() {
        XCTAssertNotNil(LOTAnimationView.infiniteLoaderAnimationView)
    }
}

