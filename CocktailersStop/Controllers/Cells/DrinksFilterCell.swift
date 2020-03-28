//
//  DrinksFilterCell.swift
//  CocktailersStop
//
//  Created by ELaunch on 05/02/20.
//  Copyright © 2020 ELaunch. All rights reserved.
//

import UIKit

class DrinksFilterCell: UICollectionViewCell {
    
    @IBOutlet weak var imgDrinkFillter: UIImageView!
    @IBOutlet weak var lblDrinktype: UILabel!
    
    override func awakeFromNib() {
        
        imgDrinkFillter.height = imgDrinkFillter.width
    }
}
