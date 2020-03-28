//
//  CocktailInstructionCell.swift
//  CocktailersStop
//
//  Created by ELaunch on 08/02/20.
//  Copyright © 2020 ELaunch. All rights reserved.
//

import UIKit

class CocktailInstructionCell: UITableViewCell {

    @IBOutlet weak var lblInstruction: UILabel!
    @IBOutlet weak var lblGlassType: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
