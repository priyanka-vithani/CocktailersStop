//
//  ViewController.swift
//  CocktailersStop
//
//  Created by ELaunch on 31/01/20.
//  Copyright © 2020 ELaunch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var sec = 0
    @IBOutlet weak var imageView: UIImageView!
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(handle), userInfo: nil, repeats: true)
    }

    @objc func handle(){
        
           
                sec += 1
                imageView.image = UIImage(named: "\(sec)")
                if sec == 28{
                    timer.invalidate()
                    let move =  self.storyboard?.instantiateViewController(withIdentifier: "HomeVC")
                   showHUD()
                    self.navigationController!.pushViewController(move!, animated: true)
                }
        
            
        }
        
        
        
        
  

}

