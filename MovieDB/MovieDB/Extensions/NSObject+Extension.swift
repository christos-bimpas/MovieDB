//
//  NSObject+Extension.swift
//  MovieDB
//
//  Created by Christos Home on 23/03/2020.
//  Copyright © 2020 Christos Bimpas. All rights reserved.
//

import Foundation

extension NSObject {
    
    static var identifier: String {
        return String(describing: self)
    }
}

