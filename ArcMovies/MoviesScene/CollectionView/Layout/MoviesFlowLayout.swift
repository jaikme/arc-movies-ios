//
//  FlowManager.swift
//  ArcMovies
//
//  Created by Jaime Costa Marques on 11/05/18.
//  Copyright © 2018 Jaime Costa Marques. All rights reserved.
//

import UIKit

class MoviesFlowLayout: UICollectionViewFlowLayout {

    fileprivate var lastCollectionViewSize: CGSize = CGSize.zero

    private let centerOffset: CGFloat = 0

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

// MARK: Configs

extension  MoviesFlowLayout {

    fileprivate func configureInsets() {
        guard let collectionView = self.collectionView else {
            return
        }

        let centerInset = collectionView.bounds.size.width / 2 - itemSize.width / 2
        let centerDisplacement = centerInset / 2
        collectionView.contentInset = UIEdgeInsetsMake(0, centerInset - centerDisplacement, 0, centerInset)
        collectionView.contentOffset = CGPoint(x: -centerInset, y: 0)
    }

}

// MARK: Overrides

extension MoviesFlowLayout {
    override func invalidateLayout(with context: UICollectionViewLayoutInvalidationContext) {
        super.invalidateLayout(with: context)
        guard let collectionView = self.collectionView else { return }

        if collectionView.bounds.size != lastCollectionViewSize {
            configureInsets()
            lastCollectionViewSize = collectionView.bounds.size
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = self.collectionView,
              let superAttributes = super.layoutAttributesForElements(in: rect) else {
            return super.layoutAttributesForElements(in: rect)
        }

        let scaleOffset: CGFloat = 200
        let minScaleFactor: CGFloat = 0.7
        let minAlphaFactor: CGFloat = 0.3
        let size = collectionView.bounds.size
        let contentOffset = collectionView.contentOffset

        let visibleRect = CGRect(x: contentOffset.x, y: contentOffset.y, width: size.width, height: size.height)
        let visibleCenterX = visibleRect.midX

        guard case let elementsAttributesArray as [UICollectionViewLayoutAttributes] = NSArray(array: superAttributes, copyItems: true) else {
            return nil
        }

        elementsAttributesArray.forEach {
            let distanceFromCenter = visibleCenterX - $0.center.x
            let absDistanceFromCenter = min(abs(distanceFromCenter), minScaleFactor)
            let scale = absDistanceFromCenter * minScaleFactor / scaleOffset + 1
            $0.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
            //$0.transform3D = CATransform3DMakeScale(1 + (minScaleFactor - 1) * absDistanceFromCenter, 1 + (minScaleFactor - 1) * absDistanceFromCenter, 1)


            let alpha = absDistanceFromCenter * (minAlphaFactor - 1) / scaleOffset + 1
            $0.alpha = alpha
        }

        return elementsAttributesArray
    }
}
