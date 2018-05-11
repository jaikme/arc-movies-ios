//
//  HomeViewController.swift
//  ArcMovies
//
//  Created by Jaime Costa Marques on 10/05/18.
//  Copyright © 2018 Jaime Costa Marques. All rights reserved.
//

import UIKit

protocol MoviesViewDisplayLogic: class {

}

class MoviesViewController: UIViewController {

    // The collection view to show the movies and change exhibition
    @IBOutlet private weak var collectionView: UICollectionView!
    
    lazy var posterSize: CGSize = {
        return CGSize(width: UIScreen.main.bounds.width / 1.5, height: UIScreen.main.bounds.height - 100)
    }()
    
    private let dataSource = MoviesCollectionDataSource()
    private let delegate = MoviesCollectionDelegate()

}

// MARK: Lifecycle

extension MoviesViewController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
}

// MARK: Configs

extension MoviesViewController {

    private func commonInit() {
        let layout = MoviesFlowLayout(itemSize: posterSize)
        setupCollectionView(with: layout)
    }
    
    func setupCollectionView(with layout: UICollectionViewFlowLayout)  {
        collectionView.isPrefetchingEnabled = false
        collectionView.decelerationRate = UIScrollViewDecelerationRateFast
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor(white: 0, alpha: 0)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        // Register collection movies cell
        registerCell()
        
        // Set layout
        collectionView.collectionViewLayout = layout
        
        // Call delegate and dataSource setups
        setupDelegate()
        setupDataSource()
    }
    
    private func setupDelegate() {
        collectionView.delegate = delegate
    }
    
    private func setupDataSource() {
        collectionView.dataSource = dataSource
    }
}

// MARK: Helpers

extension MoviesViewController {
    
    fileprivate func registerCell() {
        
        let nib = UINib(nibName: String(describing: MoviePosterCell.self), bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: String(describing: MoviePosterCell.self))
    }
}

// MARK: - MoviesViewDisplayLogic

extension MoviesViewController {
    
}
