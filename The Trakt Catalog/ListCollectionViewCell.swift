//
//  ListCollectionViewCell.swift
//  The Trakt Catalog
//
//  Created by Fabricio Rodrigues on 08/08/17.
//  Copyright © 2017 fabricio. All rights reserved.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var images: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.images.layer.masksToBounds = true
    }
}
