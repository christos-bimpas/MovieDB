//
//  SplashViewController.swift
//  MovieDB
//
//  Created by Christos Home on 22/03/2020.
//  Copyright © 2020 Christos Bimpas. All rights reserved.
//

import UIKit
import Lottie
import SnapKit

class SplashViewController: UIViewController, NavigationTitle {
    
    // MARK: - NavigationTitle
    
    var titleLabel: UILabel = UILabel()
    
    // MARK : - UI
    
    let videoCamAnimationView = LOTAnimationView.videoCamAnimationView
    
    // MARK : - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationTitleLabel(with: "Movie DB")
        setupViews()
        playAnimation()
    }
    
    // MARK : - Private methods
    
    private func setupViews() {
        guard let videoCamAnimationView = videoCamAnimationView else { return }
        
        view.addSubview(videoCamAnimationView)
        videoCamAnimationView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func playAnimation() {
        guard let videoCamAnimationView = videoCamAnimationView else {
            finish()
            return
        }
        
        videoCamAnimationView.play(fromProgress: 0, toProgress: 1) { [weak self] _ in
            self?.finish()
        }
    }
    
    private func finish() {
        let networkClient = NetworkClient()
        let viewModel = MovieDBViewModel(networkClient: networkClient)
        let viewController = MovieDBViewController(viewModel: viewModel)
        navigationController?.viewControllers = [viewController]
    }
}
