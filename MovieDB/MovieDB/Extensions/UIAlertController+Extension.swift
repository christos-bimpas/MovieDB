//
//  UIAlertController+Extension.swift
//  MovieDB
//
//  Created by Christos Home on 23/03/2020.
//  Copyright © 2020 Christos Bimpas. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    final class var noApiKeyAlert: UIAlertController {
        let alertController = UIAlertController(title: "No api key",
                                                message: "Please set the apiKey constant in MovieDBViewModel",
                                                preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        
        return alertController
    }
}
