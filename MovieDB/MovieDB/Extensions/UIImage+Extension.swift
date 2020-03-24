//
//  UIImage+Extension.swift
//  MovieDB
//
//  Created by Christos Home on 23/03/2020.
//  Copyright © 2020 Christos Bimpas. All rights reserved.
//

import UIKit

extension UIImage {
    
    private var aspectRatio: CGFloat? {
        guard size.height > 0, size.width > 0 else { return nil }
        return size.width / size.height
    }
    
    private var isWidthGreaterOrEqualToHeight: Bool {
        return size.width >= size.height
    }
    
    func imageSize(maxWidth: CGFloat, maxHeight: CGFloat) -> CGSize {
        guard let imageAspectRatio = aspectRatio else { return .zero }
    
        var width: CGFloat = 0
        var height: CGFloat = 0
        
        if isWidthGreaterOrEqualToHeight {
            height = maxHeight
            width = height * imageAspectRatio
        } else {
            width = maxWidth
            height = width / imageAspectRatio
        }
        
        if width > maxWidth {
            width = maxWidth
            height = width / imageAspectRatio
        } else if height > maxHeight {
            height = maxHeight
            width = height * imageAspectRatio
        }
        
        return CGSize(width: width, height: height)
    }
}
