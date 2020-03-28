//
//  HomeVC.swift
//  CocktailersStop
//
//  Created by ELaunch on 31/01/20.
//  Copyright © 2020 ELaunch. All rights reserved.
//

import UIKit
import AVFoundation
import TransitionButton

class HomeVC: UIViewController {
// var player = AVPlayer()
    let player = AVQueuePlayer()
    var playerLooper : AVPlayerLooper!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var btnsignup: TransitionButton!
    @IBOutlet weak var btnLogin: TransitionButton!
    @IBOutlet weak var btnSkip: TransitionButton!
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    override func viewDidAppear(_ animated: Bool) {
        
        PlayVideo()
    }
   
    @IBAction func btnSkip_clk(_ sender: Any) {
        player.pause()
        btnSkip.startAnimation()
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            
            sleep(3)
            
            DispatchQueue.main.async(execute: { () -> Void in
                
                
                self.btnSkip.stopAnimation(animationStyle: .expand, completion: {
                    
//                    let vc = loadVC(strStoryboardId: "Main", strVCId: "LoginVC") as! LoginVC
//                    APP_DELEGATE.appNavigation?.pushViewController(vc, animated: true)
                    
                    let vc = loadVC(strStoryboardId: main, strVCId: vc_tab)
                    showHUD()
                    APP_DELEGATE.appNavigation?.pushViewController(vc, animated: true)
                    
                })
            })
        })
        
    }
    
    func PlayVideo(){
        showHUD()
        guard let path = Bundle.main.path(forResource: "video2", ofType:"mp4") else {
            debugPrint("video.m4v not found")
            return
        }
        let pathURL = URL(fileURLWithPath: path)
         let duration = Int64( ( (Float64(CMTimeGetSeconds(AVAsset(url: URL(fileURLWithPath: path)).duration)) *  10.0) - 1) / 10.0 )
        
        let player = AVQueuePlayer(url: pathURL)
        let playerLayer = AVPlayerLayer(player: player)
      let playerItem = AVPlayerItem(url: pathURL)
         playerLooper = AVPlayerLooper(player: player, templateItem: playerItem, timeRange: CMTimeRange(start: CMTime.zero, end: CMTimeMake(value: duration, timescale: 1)) )
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerLayer.frame = view.layer.bounds
        view.layer.insertSublayer(playerLayer, at: 1)
        
    
       
        self.videoView.layer.addSublayer(playerLayer)
        hideHUD()
        player.play()
        
//      self.videoView.addSubview(btnLogin)
//        self.videoView.addSubview(btnsignup)
        self.videoView.addSubview(btnSkip)
        

    }

    @IBAction func btnLogin_clk(_ sender: Any) {
        btnLogin.startAnimation()
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            
            sleep(3) 
            
            DispatchQueue.main.async(execute: { () -> Void in
               
              
                self.btnLogin.stopAnimation(animationStyle: .expand, completion: {
                    
                    let vc = loadVC(strStoryboardId: main, strVCId: vc_login) as! LoginVC
                    APP_DELEGATE.appNavigation?.pushViewController(vc, animated: true)

                })
            })
        })
            }
    
        
    
    
    @IBAction func btnSignup_clk(_ sender: Any) {
        let vc = loadVC(strStoryboardId: main, strVCId: vc_signup) as! SignupVC
        APP_DELEGATE.appNavigation?.pushViewController(vc, animated: true)
    }
    

}
