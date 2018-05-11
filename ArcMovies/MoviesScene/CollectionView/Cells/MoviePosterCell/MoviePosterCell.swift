//
//  MoviePosterCell.swift
//  ArcMovies
//
//  Created by Jaime Costa Marques on 11/05/18.
//  Copyright © 2018 Jaime Costa Marques. All rights reserved.
//

import UIKit

final class MoviePosterCell: UICollectionViewCell {
    
    @IBOutlet private weak var Poster: UIImageView!
    @IBOutlet private weak var PosterContainer: UIView!
    

}

// MARK: Lifecycle

extension MoviePosterCell {
    
    override var bounds: CGRect {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Config. poster container
        PosterContainer.layer.masksToBounds = true
        PosterContainer.layer.cornerRadius = 8
        
        // Config. poster shadow
        configureShadow()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        commonInit()
    }
    
    fileprivate func commonInit() {
        configureViews()
    }
}

// MARK: Configs

extension MoviePosterCell {
    
    fileprivate func configureViews() {
        
        
        

        
        // Config. self
        contentView.layer.masksToBounds = false
        layer.masksToBounds = false
        
        
    }
    
    
    fileprivate func configureShadow() {
        let shadowView = UIView(frame: .zero)
        shadowView.backgroundColor = UIColor(white: 0, alpha: 0)
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowRadius = 10
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.shouldRasterize = true
        addShowViewWithConstraint(shadowView)
    }
}

// MARK: Helpers

extension MoviePosterCell {

    func addShowViewWithConstraint(_ view: UIView) {
        contentView.insertSubview(view, belowSubview: Poster)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    }
}
