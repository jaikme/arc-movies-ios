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
        PosterContainer.alpha = 1
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
        configureShadow()
    }
}

// MARK: Configs

extension MoviePosterCell {
    
    fileprivate func configureViews() {
        contentView.layer.masksToBounds = false
        layer.masksToBounds = false
    }
    
    fileprivate func configureShadow() {
        let shadowView = UIView(frame: .zero)
        shadowView.backgroundColor = UIColor(white: 0, alpha: 0)
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowRadius = 8
        shadowView.layer.shadowOpacity = 0.09
        shadowView.layer.shadowOffset = CGSize(width: 2, height: 0)
        shadowView.layer.shouldRasterize = true
        shadowView.layer.shadowPath = UIBezierPath(roundedRect: PosterContainer.bounds, cornerRadius: PosterContainer.layer.cornerRadius).cgPath
        addShowViewWithConstraint(shadowView)
    }
}

// MARK: Helpers

extension MoviePosterCell {

    func addShowViewWithConstraint(_ view: UIView) {
        // Insert our shadow to view
        contentView.insertSubview(view, belowSubview: PosterContainer)

        // Set Constraint
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: PosterContainer.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: PosterContainer.bottomAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: PosterContainer.trailingAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: PosterContainer.leadingAnchor).isActive = true
    }
}
