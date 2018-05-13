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
    private let scaleOffset: CGFloat = 200
    private let minScaleFactor: CGFloat = 0.8
    private let minAlphaFactor: CGFloat = 0.5

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
        
        minimumLineSpacing = -5
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

        let inset = collectionView.bounds.size.width / 2 - itemSize.width / 2
        collectionView.contentInset = UIEdgeInsetsMake(0, inset, 0, inset)
        collectionView.contentOffset = CGPoint(x: -inset, y: 0)
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
    
    override func shouldInvalidateLayout(forBoundsChange _: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = self.collectionView,
              let elementsArray = super.layoutAttributesForElements(in: rect) else {
            return super.layoutAttributesForElements(in: rect)
        }
        
        let size = collectionView.bounds.size
        let contentOffset = collectionView.contentOffset

        let visibleRect = CGRect(x: contentOffset.x, y: contentOffset.y, width: size.width, height: size.height)
        let visibleCenterX = visibleRect.midX

        elementsArray.forEach {
            let distanceFromCenter = visibleCenterX - $0.center.x
            let absDistanceFromCenter = min(abs(distanceFromCenter), scaleOffset)
            let scale = absDistanceFromCenter * (self.minScaleFactor - 1) / self.scaleOffset + 1
            $0.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
            
            let alpha = absDistanceFromCenter * (self.minAlphaFactor - 1) / self.scaleOffset + 1
            $0.alpha = alpha
        }

        return elementsArray
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = self.collectionView else {
            return proposedContentOffset
        }
        
        let proposedRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.bounds.width, height: collectionView.bounds.height)
        guard let layoutAttributes = self.layoutAttributesForElements(in: proposedRect) else {
            return proposedContentOffset
        }
        
        var candidateAttributes: UICollectionViewLayoutAttributes?
        let proposedContentOffsetCenterX = proposedContentOffset.x + collectionView.bounds.width / 2
        
        for attributes in layoutAttributes {
            if attributes.representedElementCategory != .cell {
                continue
            }
            
            if candidateAttributes == nil {
                candidateAttributes = attributes
                continue
            }
            
            if fabs(attributes.center.x - proposedContentOffsetCenterX) < fabs(candidateAttributes!.center.x - proposedContentOffsetCenterX) {
                candidateAttributes = attributes
            }
        }
        
        guard let aCandidateAttributes = candidateAttributes else {
            return proposedContentOffset
        }
        
        var newOffsetX = aCandidateAttributes.center.x - collectionView.bounds.size.width / 2
        let offset = newOffsetX - collectionView.contentOffset.x
        
        if (velocity.x < 0 && offset > 0) || (velocity.x > 0 && offset < 0) {
            let pageWidth = itemSize.width + minimumLineSpacing
            newOffsetX += velocity.x > 0 ? pageWidth : -pageWidth
        }
        
        return CGPoint(x: newOffsetX, y: proposedContentOffset.y)
    }
}
