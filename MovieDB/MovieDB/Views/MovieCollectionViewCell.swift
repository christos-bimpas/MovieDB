//
//  MovieCollectionViewCell.swift
//  MovieDB
//
//  Created by Christos Home on 23/03/2020.
//  Copyright © 2020 Christos Bimpas. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage
import Lottie

class MovieCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Constants
    
    private let genericOffset: CGFloat = 20
    private let posterWidthMuliplier: CGFloat = 0.4
    private let voteAverageHeight: CGFloat = 24
    
    // MARK: - Properties
    
    var viewModel: MovieViewModel? {
        didSet {
            titleLabel.text = viewModel?.title
            dateLabel.text = viewModel?.releaseDate
            overviewLabel.text = viewModel?.overview
            voteAverageLabel.text = viewModel?.voteAverage
            voteAverageLabel.textColor = viewModel?.voteAverageTextColor
            
            guard let url = viewModel?.posterURL else { return }
            posterImageView.sd_setImage(with: url)
        }
    }
    
    // MARK: - UI Elements
    
    lazy private var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        
        return label
    }()
     
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var voteAverageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        
        return label
    }()
        
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupViews() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(voteAverageLabel)
        
        posterImageView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(posterWidthMuliplier)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(posterImageView.snp.right).offset(genericOffset)
            make.top.equalToSuperview().offset(genericOffset)
            make.right.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalTo(titleLabel)
            make.right.equalToSuperview().offset(-genericOffset)
        }
        
        voteAverageLabel.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview().offset(-genericOffset)
            make.height.equalTo(voteAverageHeight)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(genericOffset)
            make.left.equalTo(titleLabel)
            make.right.equalToSuperview().offset(-genericOffset)
            make.bottom.lessThanOrEqualTo(voteAverageLabel.snp.top).offset(-genericOffset)
        }
    }
}
