//
//  MoviePosterCell.swift
//  ArcMovies
//
//  Created by Jaime Costa Marques on 11/05/18.
//  Copyright © 2018 Jaime Costa Marques. All rights reserved.
//

import UIKit

// _Colorable_ is a protocol to handler dominant colors
protocol Colorable {
    func dominantColor( _ primary: UIColor )
}

// MARK: -  MoviePosterCell

/// _MoviePosterCell_ is the collection view cell responsible to display our Movie poster
final class MoviePosterCell: UICollectionViewCell {
    
    @IBOutlet private weak var Poster: UIImageView!
    @IBOutlet private weak var PosterContainer: UIView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    private let cornerRadius: CGFloat = 10
    private var shadowView: UIView? = nil
    var colorable: Colorable!
    
    var viewModel: MoviesViewModel? {
        didSet {
            setPosterImage()
        }
    }
    
    var isTouched: Bool = false {
        didSet {
            var transform = CGAffineTransform.identity
            if isTouched { transform = transform.scaledBy(x: 0.96, y: 0.96) }
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
                self.transform = transform
            }, completion: nil)
        }
    }
    
    // Prepate cell for image block load
    override func prepareForReuse() {
        super.prepareForReuse()
        Poster.alpha = 0
        Poster.image = nil
        shadowView?.alpha = 0
        shadowView?.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height), cornerRadius: PosterContainer.layer.cornerRadius).cgPath
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - Touch Override Effect
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        isTouched = true
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        isTouched = false
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        isTouched = false
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        isTouched = true
    }
    
}

// MARK: Lifecycle

extension MoviePosterCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        commonInit()
    }

    private func commonInit() {
        configureViews()
    }
}

// MARK: Configs

extension MoviePosterCell {
    
    private func setPosterImage() {
        // Start loader feedback
        activityIndicator.startAnimating()
        
        // Load the poster url
        Poster.setImageURL(url: viewModel?.posterURL) { [weak self] in
            
            // Stop de loader when completes
            self?.activityIndicator.stopAnimating()
            
            //Show Poster animated
            self?.showPoster()
            
            // Configure colors
            self?.defineColors(with: self?.Poster.image)
        }
    }
    
    private func showPoster() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.Poster.alpha = 1
                self?.layoutIfNeeded()
            }
        }
    }
    
    private func showShadow(_ shadow : UIView?) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2) { [weak self] in
                shadow?.alpha = 1
                self?.layoutIfNeeded()
            }
        }
    }

    private func configureViews() {
        // Config. poster container
        PosterContainer.layer.masksToBounds = true
        PosterContainer.layer.cornerRadius = cornerRadius
        PosterContainer.alpha = 1
        
        // Config. self
        contentView.layer.masksToBounds = false
        layer.masksToBounds = false
    }
    
    private func configureShadow() {
        guard self.shadowView == nil else {
            // Show shadow
            showShadow(self.shadowView)
            return
        }
        var shadowView = UIView(frame: .zero)

        // Set poster shadow
        With(&shadowView) {
            $0.alpha = 0
            $0.backgroundColor = UIColor(white: 0, alpha: 0)
            $0.layer.masksToBounds = false
            $0.layer.shadowColor = UIColor(white: 0, alpha: 0).cgColor
            $0.layer.shadowRadius = 25
            $0.layer.shadowOpacity = 0.5
            $0.layer.shadowOffset = CGSize(width: 0, height: 8)
            $0.layer.shouldRasterize = true
            $0.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height), cornerRadius: PosterContainer.layer.cornerRadius).cgPath
        }
        addShowViewWithConstraint(shadowView)
    }
    
    /// Define views colors
    private func defineColors(with image: UIImage?) {
        guard let image = image else { return }
        DispatchQueue.main.async {
            image.getColors(quality: .low) { [weak self] colors in
                self?.setShadowColor(with: colors.background.cgColor)

                // Picks the primary color and darkens it
                guard let darkColor = colors.secondary.darker(by: 40) else { return }
                self?.colorable.dominantColor(darkColor)
                
                // Add border to avoid white poster background
                self?.PosterContainer.layer.borderColor = darkColor.withAlphaComponent(0.2).cgColor
                self?.PosterContainer.layer.borderWidth = 1
                
            }
        }
    }
    
    /// Set shadow color dominant
    private func setShadowColor(with color: CGColor) {
        self.shadowView?.layer.shadowColor = color
        
        // Show or Create shadow
        configureShadow()
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

        // Store shadow
        shadowView = shadow
    }
}
