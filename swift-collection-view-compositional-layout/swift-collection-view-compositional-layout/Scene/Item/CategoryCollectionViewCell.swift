//
//  CategoryCollectionViewCell.swift
//  swift-collection-view-compositional-layout
//
//  Created by 정희수 on 5/8/25.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "CategoryCollectionViewCell"
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var label: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        containerView.layer.cornerRadius = 8
        containerView.backgroundColor = .systemGray4
    }

}
