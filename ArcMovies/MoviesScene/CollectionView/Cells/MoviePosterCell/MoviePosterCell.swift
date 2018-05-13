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
    
    private let cornerRadius: CGFloat = 10

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: Lifecycle

extension MoviePosterCell {
    
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
        // Config. poster container
        PosterContainer.layer.masksToBounds = true
        PosterContainer.layer.cornerRadius = cornerRadius
        PosterContainer.alpha = 1
        
        // Config. self
        contentView.layer.masksToBounds = false
        layer.masksToBounds = false
    }
    
    fileprivate func configureShadow() {
        var shadowView = UIView(frame: .zero)
        
        // Set poster shadow
        With(&shadowView) {
            $0.backgroundColor = UIColor(white: 0, alpha: 0)
            $0.layer.masksToBounds = false
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowRadius = 10
            $0.layer.shadowOpacity = 0.4
            $0.layer.shadowOffset = CGSize(width: 0, height: 3)
            $0.layer.shouldRasterize = true
            $0.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Poster.bounds.width, height: PosterContainer.bounds.height), cornerRadius: PosterContainer.layer.cornerRadius).cgPath
        }
        addShowViewWithConstraint(shadowView)
    }
}

// MARK: Helpers

extension MoviePosterCell {

    func addShowViewWithConstraint(_ shadow: UIView) {
        // Insert our shadow to view
        contentView.insertSubview(shadow, belowSubview: PosterContainer)

        // Set shadow constraints
        shadow.translatesAutoresizingMaskIntoConstraints = false
        shadow.topAnchor.constraint(equalTo: PosterContainer.topAnchor).isActive = true
        shadow.bottomAnchor.constraint(equalTo: PosterContainer.bottomAnchor).isActive = true
        shadow.trailingAnchor.constraint(equalTo: PosterContainer.trailingAnchor).isActive = true
        shadow.leadingAnchor.constraint(equalTo: PosterContainer.leadingAnchor).isActive = true
    }
}
