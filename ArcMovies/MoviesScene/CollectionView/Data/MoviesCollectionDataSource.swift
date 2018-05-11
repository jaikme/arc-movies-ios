//
//  MoviesCollectionDataSource.swift
//  ArcMovies
//
//  Created by Jaime Costa Marques on 11/05/18.
//  Copyright © 2018 Jaime Costa Marques. All rights reserved.
//

import UIKit

final class MoviesCollectionDataSource : NSObject {
    
    
}

extension MoviesCollectionDataSource : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: MoviePosterCell.self),
                for: indexPath )
            as? MoviePosterCell
            else { return MoviePosterCell()  }
        return cell
    }
    
    
}
