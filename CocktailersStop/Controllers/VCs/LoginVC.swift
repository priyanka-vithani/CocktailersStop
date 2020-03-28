//
//  LoginVC.swift
//  CocktailersStop
//
//  Created by ELaunch on 31/01/20.
//  Copyright © 2020 ELaunch. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var txtUserId: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        txtUserId.delegate = self
        txtPassword.delegate = self
        setupUI()
    }
    func setupUI(){
        txtPassword.setPlaceHolderTextColor(UIColor.darkGray)
        txtPassword.addPaddingLeft(20)
        txtUserId.setPlaceHolderTextColor(UIColor.darkGray)
        txtUserId.addPaddingLeft(20)
         UITextField.appearance().tintColor = themeRedColor
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return self.view.endEditing(true)
    }

    @IBAction func btnForgotPass_clk(_ sender: Any) {
    }
    @IBAction func btnLogin_clk(_ sender: Any) {
        let vc = loadVC(strStoryboardId: main, strVCId: vc_tab)
        APP_DELEGATE.appNavigation?.pushViewController(vc, animated: true)
        
    }
    @IBAction func btnSignup_clk(_ sender: Any) {
        let vc = loadVC(strStoryboardId: main, strVCId: vc_signup) as! SignupVC
        APP_DELEGATE.appNavigation?.pushViewController(vc, animated: true)
    }
    
}
extension LoginVC: UITextFieldDelegate{
   
}
