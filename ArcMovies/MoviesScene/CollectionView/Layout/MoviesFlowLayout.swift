//
//  FlowManager.swift
//  ArcMovies
//
//  Created by Jaime Costa Marques on 11/05/18.
//  Copyright © 2018 Jaime Costa Marques. All rights reserved.
//

import UIKit

class MoviesFlowLayout: UICollectionViewFlowLayout {
    
    
    init(itemSize: CGSize) {
        super.init()
        commonInit(itemSize)
    }
    
    // Ignoring init with coder
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

// MARK: Lifecycle

extension MoviesFlowLayout {
    
    fileprivate func commonInit(_ itemSize: CGSize) {
        
        minimumLineSpacing = 25
        scrollDirection = .horizontal
        self.itemSize = itemSize
    }
}
