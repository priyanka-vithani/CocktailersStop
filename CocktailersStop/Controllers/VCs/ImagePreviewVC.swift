//
//  ImagePreviewVC.swift
//  CocktailersStop
//
//  Created by ELaunch on 13/02/20.
//  Copyright © 2020 ELaunch. All rights reserved.
//

import UIKit
import ImageScrollView



class ImagePreviewVC: UIViewController {

    @IBOutlet weak var lblCocktail: UILabel!
    @IBOutlet weak var imgScrlvw: ImageScrollView!
    var img = UIImage()
    var name = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        lblCocktail.text = name
        imgScrlvw.setup()
        imgScrlvw.imageContentMode = .aspectFit
        imgScrlvw.initialOffset = .center
        imgScrlvw.display(image: img)
        
       
    }
    @IBAction func btnBack_clk(_ sender: Any) {
        APP_DELEGATE.appNavigation?.popViewController(animated: true)
    }
    

 

}


