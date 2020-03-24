//
//  Error+Extension.swift
//  MovieDB
//
//  Created by Christos Home on 22/03/2020.
//  Copyright © 2020 Christos Bimpas. All rights reserved.
//

import Foundation

enum CustomError: Error {
    case unknownError
    case couldNotParsePage
}

extension CustomError: LocalizedError {

    var errorDescription: String? {
        switch self {
        case  .unknownError:
            return "Unknown Error"
        case  .couldNotParsePage:
            return "Could not parse page"
        }
    }
}
