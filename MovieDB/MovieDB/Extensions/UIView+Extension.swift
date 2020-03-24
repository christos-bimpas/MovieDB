//
//  UIView+Extension.swift
//  MovieDB
//
//  Created by Christos Home on 23/03/2020.
//  Copyright © 2020 Christos Bimpas. All rights reserved.
//

import UIKit

extension UIView {
    
    func displaySubViews(withAnimationDuration duration: Double) {
        subviews.forEach { subview in
            UIView.animate(withDuration: duration, animations: {
                subview.alpha = 1.0
            })
        }
    }
    
    func hideSubViews(withAnimationDuration duration: Double) {
        subviews.forEach { subview in
            UIView.animate(withDuration: duration, animations: {
                subview.alpha = 0.0
            })
        }
    }
}
