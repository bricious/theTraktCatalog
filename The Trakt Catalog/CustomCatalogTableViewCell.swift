//
//  CustomCatalogTableViewCell.swift
//  The Trakt Catalog
//
//  Created by Fabricio Dos Santos Rodrigues on 07/08/17.
//  Copyright © 2017 fabricio. All rights reserved.
//

import UIKit

class CustomCatalogTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelYear: UILabel!
    @IBOutlet weak var imageMovie: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.imageMovie.layer.cornerRadius = 10
        self.imageMovie.layer.borderColor = UIColor.lightGray.cgColor
        self.imageMovie.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
