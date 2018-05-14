//
//  MovieDetailsTable.swift
//  ArcMovies
//
//  Created by Jaime Costa Marques on 13/05/18.
//  Copyright © 2018 Jaime Costa Marques. All rights reserved.
//

import UIKit

/// _MovieDetailsTable_ A static table view which will show the movie details
final class MovieDetailsTable : UITableView {
    
    @IBOutlet private weak var Poster: UIImageView!
    @IBOutlet private weak var movieTitle: UILabel!
    @IBOutlet private weak var overview: UILabel!
    @IBOutlet private weak var genres: UILabel!
    @IBOutlet private weak var releaseDate: UILabel!
    @IBOutlet private weak var closeButton: UIButton!
    
    private var shadowView: UIView? = nil
    
    var movieDetails: MovieViewModel? {
        didSet {
            setPosterImage()
            setReleaseDate()
            setGenres()
            setOverview()
            setTitle()
            
        }
    }

}

// MARK: Lifecycles

extension MovieDetailsTable {
    override func awakeFromNib() {
        // Configure initial
        configPoster()
    }
}

// MARK: Methods

extension MovieDetailsTable {
    
    private func setPosterImage() {
        Poster.setImageURL(url: movieDetails?.posterURL) { [weak self] in
            self?.setShadow()
            self?.showHiddenViews()
        }
    }
    
    private func setGenres() {
        genres.text = movieDetails?.genres
    }
    
    private func setReleaseDate() {
        releaseDate.text = movieDetails?.releaseDate
    }
    
    private func setOverview() {
        overview.text = movieDetails?.overview
    }
    
    private func setTitle() {
        movieTitle.text = movieDetails?.title
    }
    
    private func showHiddenViews() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: { [weak self] in

            self?.releaseDate.alpha = 1
            self?.movieTitle.alpha = 1
            self?.overview.alpha = 1
            self?.Poster.alpha = 1
            self?.shadowView?.alpha = 1
        }, completion: nil)
    }
    
    private func setShadow() {
        var shadowView = UIView(frame: .zero)
        // TODO: Create a abstract class to deal with poster shadow redundance
        
        guard let PosterContainer = Poster.superview else {
            return
        }
        
        // Apply corner to poster image
        applyCorner(to: PosterContainer)
        
        // Set poster shadow
        With(&shadowView) {
            $0.alpha = 0
            $0.backgroundColor = UIColor(white: 0, alpha: 0)
            $0.layer.masksToBounds = false
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowRadius = 10
            $0.layer.shadowOpacity = 0.3
            $0.layer.shadowOffset = CGSize(width: 0, height: 5)
            $0.layer.shouldRasterize = true
            $0.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: PosterContainer.frame.minX, y: 25, width: PosterContainer.frame.width, height: PosterContainer.frame.height), cornerRadius: PosterContainer.layer.cornerRadius).cgPath
        }
        
        guard let ImageCellView = PosterContainer.superview else { return }
        ImageCellView.insertSubview(shadowView, belowSubview: PosterContainer)
        self.shadowView = shadowView
    }
}

// MARK: Methods.

extension MovieDetailsTable {
    
    func configColors(with backgroundColor: UIColor?) {
        movieTitle.textColor = backgroundColor
        releaseDate.textColor = backgroundColor
        genres.textColor = backgroundColor
        overview.textColor = backgroundColor
    }
}

// MARK: Configs.

extension MovieDetailsTable {
    
    private func applyCorner(to superView: UIView) {
        superView.layer.masksToBounds = true
        superView.layer.cornerRadius = 6
    }

    private func configPoster() {
        releaseDate.alpha = 0
        movieTitle.alpha = 0
        overview.alpha = 0
        Poster.alpha = 0
    }
}
