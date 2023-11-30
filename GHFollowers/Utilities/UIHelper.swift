//
//  UIHelper.swift
//  GHFollowers
//
//  Created by Onurcan Sever on 2023-11-28.
//

import UIKit

struct UIHelper {
    
    static func createThreeColumnLayout(in view: UIView) -> UICollectionViewFlowLayout {
        // Get the width of the device.
        let width = view.bounds.width
        // Set the padding and minimum item spacing.
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        // (padding * 2) -> left and right padding from the super view.
        // (padding) [] - [] - [] (padding)
        // (minimumItemSpacing * 2) -> since it's three grid layout, there will be total of two spaces between the cell. [] - [] - []
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        // Divide the available width by 3 to get the width of each cell.
        let itemWidth = availableWidth / 3
        // Initialize the layout. (How the cells will be displayed)
        let flowLayout = UICollectionViewFlowLayout()
        // Set the section inset. (padding)
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        // Set the item size. (Square avatar + 40 is for the username label)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
}
