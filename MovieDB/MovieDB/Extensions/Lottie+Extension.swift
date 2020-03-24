//
//  Lottie+Extension.swift
//  MovieDB
//
//  Created by Christos Home on 22/03/2020.
//  Copyright © 2020 Christos Bimpas. All rights reserved.
//

import Lottie

extension LOTAnimationView {
    
    final class var videoCamAnimationView: LOTAnimationView? {
        let filename = "video_cam"
        guard filename.isValidResourceFile else { return nil }
        
        let view = LOTAnimationView(name: filename, bundle: Bundle.main)
        view.contentMode = .scaleAspectFit
        
        return view
    }
    
    final class var infiniteLoaderAnimationView: LOTAnimationView? {
        let filename = "loader_4"
        
        guard filename.isValidResourceFile else {
            return nil
        }
        
        let view = LOTAnimationView(name: filename, bundle: Bundle.main)
        view.contentMode = .scaleAspectFit
        view.loopAnimation = true
        
        return view
    }
}
