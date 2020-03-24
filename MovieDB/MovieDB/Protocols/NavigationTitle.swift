//
//  NavigationTitle.swift
//  MovieDB
//
//  Created by Christos Home on 22/03/2020.
//  Copyright © 2020 Christos Bimpas. All rights reserved.
//

import UIKit

protocol NavigationTitle {
    var titleLabel: UILabel { get set }
}

extension NavigationTitle where Self: UIViewController {
    
    func configureNavigationTitleLabel(with title: String?) {
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.alpha = 0.0
        titleLabel.textAlignment = .center
        navigationItem.titleView = titleLabel
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.titleLabel.alpha = 1.0
        }
    }
}
