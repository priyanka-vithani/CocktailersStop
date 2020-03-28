//
//  CategoryFilterCell.swift
//  CocktailersStop
//
//  Created by ELaunch on 05/02/20.
//  Copyright © 2020 ELaunch. All rights reserved.
//

import UIKit
import CollectionViewSlantedLayout

let yOffsetSpeed: CGFloat = 150.0
let xOffsetSpeed: CGFloat = 100.0
class CategoryFilterCell: CollectionViewSlantedCell {
    @IBOutlet weak var imgCategory: UIImageView!
    @IBOutlet weak var lblCategoryFilter: UILabel!
    
    
    private var gradient = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let backgroundView = backgroundView {
            gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
            gradient.locations = [0.0, 1.0]
            gradient.frame = backgroundView.bounds
            backgroundView.layer.addSublayer(gradient)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let backgroundView = backgroundView {
            gradient.frame = backgroundView.bounds
        }
    }
    
    var image: UIImage = UIImage() {
        didSet {
            imgCategory.image = image
        }
    }
    
    var imageHeight: CGFloat {
        return (imgCategory?.image?.size.height) ?? 0.0
    }
    
    var imageWidth: CGFloat {
        return (imgCategory?.image?.size.width) ?? 0.0
    }
    
    func offset(_ offset: CGPoint) {
        imgCategory.frame = imgCategory.bounds.offsetBy(dx: offset.x, dy: offset.y)
    }
    
}
