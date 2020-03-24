//
//  String+Extension.swift
//  MovieDB
//
//  Created by Christos Home on 22/03/2020.
//  Copyright © 2020 Christos Bimpas. All rights reserved.
//

import Foundation

extension String {
    
    var isValidResourceFile: Bool {
        guard Bundle.main.url(forResource: self, withExtension: "json") != nil else {
            return false
        }
        return true
    }
}
