//
//  CompositionalLayout.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 17.02.2024.
//

import Foundation
import UIKit

extension VehicleView {
    
    private enum Constants {
        enum Item {
            static let widthFraction: CGFloat = 1
            static let heightFraction: CGFloat = 0.8
            static let insets : CGFloat = 8
        }
       
        enum Group {
            static let widthFraction: CGFloat = 1
            static let heightDimensionAbsolute: CGFloat = 112
        }
    }

    public func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionNumber, _ -> NSCollectionLayoutSection? in
            switch sectionNumber {
                case 0: return self.createSection()
                default: return self.createSection()
            }
        }
    }

    private func createLayoutItem(widthFraction: CGFloat, heightFraction: CGFloat) -> NSCollectionLayoutItem {
         let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(widthFraction), heightDimension: .fractionalHeight(heightFraction))
         let item = NSCollectionLayoutItem(layoutSize: itemSize)
         return item
     }

     // Функция создания layout group
    private func createGroup(layoutSize: NSCollectionLayoutSize, subitems: [NSCollectionLayoutItem]) -> NSCollectionLayoutGroup {
         return NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitems: subitems)
         }
       
        
    private func createSection() -> NSCollectionLayoutSection {
        let item = createLayoutItem(widthFraction: Constants.Item.widthFraction, heightFraction: Constants.Item.heightFraction)
        item.contentInsets = NSDirectionalEdgeInsets(top: Constants.Item.insets,
                                                     leading: Constants.Item.insets,
                                                     bottom: Constants.Item.insets,
                                                     trailing: Constants.Item.insets)
        let group = createGroup(layoutSize: .init(widthDimension: .fractionalWidth(1), 
                                                  heightDimension: .absolute(Constants.Group.heightDimensionAbsolute)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
            section.visibleItemsInvalidationHandler = { (items, offset, environment) in
                       items.forEach { item in
                           let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                           let minScale: CGFloat = 0.8
                           let maxScale: CGFloat = 1.1
                           let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                           item.transform = CGAffineTransform(scaleX: scale, y: scale)
                       }
                   }
            return section
    }
    
    private func createHeaderItem(height: CGFloat, kind: String) -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(height))
        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: kind, alignment: .top)
        headerElement.pinToVisibleBounds = true
        return headerElement
    }

}
