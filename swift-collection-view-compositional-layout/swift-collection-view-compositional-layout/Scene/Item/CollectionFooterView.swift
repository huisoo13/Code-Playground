//
//  CollectionFooterView.swift
//  swift-collection-view-compositional-layout
//
//  Created by 정희수 on 5/8/25.
//

import UIKit

class CollectionFooterView: UICollectionReusableView {

    static let reuseIdentifier = "CollectionFooterView"
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
