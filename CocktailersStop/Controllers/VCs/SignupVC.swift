//
//  SignupVC.swift
//  CocktailersStop
//
//  Created by ELaunch on 31/01/20.
//  Copyright © 2020 ELaunch. All rights reserved.
//

import UIKit

class SignupVC: UIViewController {

    @IBOutlet weak var txtEmailId: UITextField!
    @IBOutlet weak var txtFname: UITextField!
    @IBOutlet weak var txtLname: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnPass: UIButton!
    @IBOutlet weak var txtDob: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtMobNum: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnPassView_vlk(_ sender: Any) {
    }
    @IBAction func btnLogin_clk(_ sender: Any) {
        let vc = loadVC(strStoryboardId: main, strVCId: vc_login) as! LoginVC
        APP_DELEGATE.appNavigation?.pushViewController(vc, animated: true)
    }
   

}
