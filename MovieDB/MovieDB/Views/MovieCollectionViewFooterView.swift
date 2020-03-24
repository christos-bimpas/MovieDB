//
//  MovieCollectionViewFooterView.swift
//  MovieDB
//
//  Created by Christos Home on 23/03/2020.
//  Copyright © 2020 Christos Bimpas. All rights reserved.
//

import UIKit
import SnapKit
import Lottie

class MovieCollectionViewFooterView: UICollectionReusableView {
    
    //MARK: - Constants
    
    private let loaderWidthMultiplier: CGFloat = 0.4
    
    // MARK: - UI Elements
    
    private let infiniteLoaderAnimationView = LOTAnimationView.infiniteLoaderAnimationView
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func startAnimating() {
        infiniteLoaderAnimationView?.play()
    }
    
    func stopAnimating() {
        infiniteLoaderAnimationView?.stop()
    }
    
    // MARK: - Private methods
    
    private func setupViews() {
        guard let infiniteLoaderAnimationView = infiniteLoaderAnimationView else { return }
        
        addSubview(infiniteLoaderAnimationView)
        infiniteLoaderAnimationView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(loaderWidthMultiplier)
        }
    }
}
