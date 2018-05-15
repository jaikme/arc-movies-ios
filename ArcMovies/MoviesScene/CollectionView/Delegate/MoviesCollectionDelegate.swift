//
//  MoviesCollectionDelegate.swift
//  ArcMovies
//
//  Created by Jaime Costa Marques on 11/05/18.
//  Copyright © 2018 Jaime Costa Marques. All rights reserved.
//

import UIKit

/// Movies controller delegate to control our collection view
extension MoviesViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MoviePosterCell else { return }
        cell.isTouched = true
        router.navigateToMovie(atIndexPath: indexPath)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? MoviePosterCell else { return }
        let items = moviesViewModels
        let index = indexPath.row % items.count
        let model = items[index]
        cell.viewModel = model
        checkNextPage(at: index)
    }
    
    // Simple page handler
    func checkNextPage(at index: Int) {
        guard index > moviesViewModels.count - 4, isPerformingPage == false else { return }
        MoviesStore.moviesPage += 1
        output.fetchMovies()
        isPerformingPage = true
    }
    
}
