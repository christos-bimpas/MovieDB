//
//  Collection+Extension.swift
//  MovieDB
//
//  Created by Christos Home on 22/03/2020.
//  Copyright © 2020 Christos Bimpas. All rights reserved.
//

import Foundation

extension Collection {
    
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
