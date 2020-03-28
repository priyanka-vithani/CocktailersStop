//
//  ForgotPassView.swift
//  CocktailersStop
//
//  Created by ELaunch on 01/02/20.
//  Copyright © 2020 ELaunch. All rights reserved.
//

import UIKit

class ForgotPassView: UIView {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    
    override func awakeFromNib() {
        txtEmail.addPaddingLeft(20)
        txtEmail.setPlaceHolderTextColor(UIColor.darkGray)
    }

    @IBAction func btnBack_clk(_ sender: Any) {
       APP_DELEGATE.appNavigation?.popViewController(animated: true)
        
    }
    
    @IBAction func btnSend_clk(_ sender: Any) {
        
        
        
    }
}
