//
//  CategoryListVC.swift
//  CocktailersStop
//
//  Created by ELaunch on 01/02/20.
//  Copyright © 2020 ELaunch. All rights reserved.
//

import UIKit


class CategoryListVC: UIViewController {

  
    @IBOutlet weak var sc: UISegmentedControl!
    @IBOutlet weak var tblCategoryList: UITableView!
    
    
    var urlString = ""
    var arr = [Any]()
    var arrCategory = [Any]()
    var arrGlasses = [Any]()
    var arrDrinks = [Any]()
    var arrHeader = ["Cocktails","Glasses","Drink Type"]
    var arrImgHeader : [UIImage] = [#imageLiteral(resourceName: "cocktail (3)"),#imageLiteral(resourceName: "wine"),#imageLiteral(resourceName: "alcohol")]
    var lbl = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tblCategoryList.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.001))
        api_Drinks()
        api_Glasses()
        api_Category()
      //  segmentVW.textFont = .boldSystemFont(ofSize: 16)
    
        
    }
    override func viewDidAppear(_ animated: Bool) {
   //     segmentedControl(segmentVW, didScrollWithXOffset: 0)
    //   segmentVW.currentSegment = 0
    
       
    }

    @IBAction func sc_clk(_ sender: UISegmentedControl) {
    
        let index = sc.selectedSegmentIndex
        switch index {
        case 0:
            tblCategoryList.scrollToTop(row: 0, section: 0)
        case 1:
            tblCategoryList.scrollToTop(row: 0, section: 1)
        case 2:
            tblCategoryList.scrollToTop(row: 0, section: 2)
        default:
            break
        }
        
    }
    
}



extension CategoryListVC{
    func api_Category(){
        if isConnectedToNetwork() == false { return }
        urlString = WS_URL + listfile + "c=list"
        HttpRequestManager.sharedInstance.getRequest(endpointurl: urlString, service: "", parameters: ["":""], keyname: "", message: "", showLoader: false) { (error, respArr, respDict) in
            if error != nil
            {
                return
            }else{
                if respArr != nil{
                    if respArr!.count > 0{
                        self.arrCategory = respArr as! [Any]
                        self.tblCategoryList.reloadSections([0], with: .automatic)
                    }else{
                        print(respArr!.count)
                    }
                }else{
                    self.arr = []
                       self.tblCategoryList.reloadData()
                }
            }
        }
    }
    func api_Glasses(){
        if isConnectedToNetwork() == false { return }
        urlString = WS_URL + listfile + "g=list"
        HttpRequestManager.sharedInstance.getRequest(endpointurl: urlString, service: "", parameters: ["":""], keyname: "", message: "", showLoader: false) { (error, respArr, respDict) in
            if error != nil
            {
                return
            }else{
                if respArr != nil{
                    if respArr!.count > 0{
                        
                        let temp = respArr as! [[String : Any]]
                        for i in temp
                        {
                            let str = i["strGlass"] as? String ?? ""
                            if str.count > 0{
                                self.arrGlasses.append(i)
                            }
                        }
                        
                        self.tblCategoryList.reloadData()
                    }else{
                        print(respArr!.count)
                    }
                }else{
                    self.arr = []
                   self.tblCategoryList.reloadSections([1], with: .automatic)
                    
                }
            }
        }
    }
    func api_Drinks(){
        showHUD()
        if isConnectedToNetwork() == false {
            hideHUD()
            return
        }
        urlString = WS_URL + listfile + "a=list"
        HttpRequestManager.sharedInstance.getRequest(endpointurl: urlString, service: "", parameters: ["":""], keyname: "", message: "", showLoader: false) { (error, respArr, respDict) in
            if error != nil
            {
                hideHUD()
                return
            }else{
                if respArr != nil{
                    if respArr!.count > 0{
                        
                        let temp = respArr as! [[String : Any]]
                        for i in temp{
                            if !(i["strAlcoholic"] is NSNull){
                                self.arrDrinks.append(i)
                            }
                        }
                        hideHUD()
                       self.tblCategoryList.reloadSections([2], with: .automatic)
                    }else{
                        hideHUD()
                        print(respArr!.count)
                    }
                }else{
                    self.arr = []
                    hideHUD()
                   self.tblCategoryList.reloadData()
            }
        }
    }
}
}
extension CategoryListVC:UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrHeader.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arrHeader[section]
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.backgroundView?.backgroundColor = #colorLiteral(red: 0.7215686275, green: 0.7215686275, blue: 0.7215686275, alpha: 0.5)
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return arrCategory.count
        case 1:
            return arrGlasses.count
        case 2:
            return arrDrinks.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_catList, for: indexPath)
        switch indexPath.section {
        case 0:
            let temp = arrCategory[indexPath.row] as! [String:Any]
            lbl = cell.viewWithTag(53) as! UILabel
            lbl.text = (temp["strCategory"] as! String)
        case 1:
            let temp = arrGlasses[indexPath.row] as! [String:Any]
            lbl = cell.viewWithTag(53) as! UILabel
            lbl.text = (temp["strGlass"] as! String)
        case 2:
            let temp = arrDrinks[indexPath.row] as! [String:Any]
            lbl = cell.viewWithTag(53) as! UILabel
            lbl.text = (temp["strAlcoholic"] as! String)
            
        default:
            let temp = arrDrinks[indexPath.row] as! [String:Any]
            lbl = cell.viewWithTag(53) as! UILabel
            lbl.text = (temp["strCategory"] as! String)
        }
      
    
          return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let cell = tableView.cellForRow(at: indexPath)
        lbl = cell?.viewWithTag(53) as! UILabel
        let name = lbl.text
        switch indexPath.section {
        case 0:
            
            let vc = loadVC(strStoryboardId: main, strVCId: vc_catFilter) as! CategoryFilterVC
            showHUD()
            vc.urlComponent = "c="
            vc.categoryName = name ?? ""
            APP_DELEGATE.appNavigation?.pushViewController(vc, animated: true)
        case 1:
            
            let vc = loadVC(strStoryboardId: main, strVCId: vc_catFilter) as! CategoryFilterVC
            showHUD()
            vc.urlComponent = "g="
             vc.categoryName = name ?? ""
            APP_DELEGATE.appNavigation?.pushViewController(vc, animated: true)
        case 2:
            
            let vc = loadVC(strStoryboardId: main, strVCId: vc_catFilter) as! CategoryFilterVC
            showHUD()
            vc.urlComponent = "a="
            vc.categoryName = name ?? ""
            APP_DELEGATE.appNavigation?.pushViewController(vc, animated: true)
        default:
            
            let vc = loadVC(strStoryboardId: main, strVCId: vc_catFilter) as! CategoryFilterVC
            vc.categoryName = name ?? ""
            APP_DELEGATE.appNavigation?.pushViewController(vc, animated: true)
        }
        
       
        
    }
    
    
}



//extension CategoryListVC : SJFluidSegmentedControlDataSource,SJFluidSegmentedControlDelegate{
//
//    func numberOfSegmentsInSegmentedControl(_ segmentedControl: SJFluidSegmentedControl) -> Int {
//        return 3
//    }
//    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, titleForSegmentAtIndex index: Int) -> String? {
//        switch index {
//        case 0:
//            return "Cocktails"
//        case 1:
//            return "Glasses"
//        case 2:
//            return "Drinks"
//        default:
//            break
//        }
//        return ""
//    }
//    //    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, titleColorForSelectedSegmentAtIndex index: Int) -> UIColor {
//    //        switch index {
//    //        case 0:
//    //            return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//    //        case 1:
//    //            return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//    //        case 2:
//    //            return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//    //        default:
//    //            break
//    //        }
//    //        return .clear
//    //    }
//    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, gradientColorsForSelectedSegmentAtIndex index: Int) -> [UIColor] {
//        switch index {
//        case 0:
//
//            return [#colorLiteral(red: 0.9921568627, green: 0.09411764706, blue: 0.0431372549, alpha: 1),#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)]
//        case 1:
//
//            return [#colorLiteral(red: 0.9921568627, green: 0.09411764706, blue: 0.0431372549, alpha: 1),#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)]
//        case 2:
//
//            return [#colorLiteral(red: 0.9921568627, green: 0.09411764706, blue: 0.0431372549, alpha: 1),#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)]
//        default:
//            break
//        }
//        return [.clear]
//    }
//    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
//                          gradientColorsForBounce bounce: SJFluidSegmentedControlBounce) -> [UIColor] {
//        switch bounce {
//        case .left:
//            return [#colorLiteral(red: 0.9921568627, green: 0.09411764706, blue: 0.0431372549, alpha: 1)]
//        case .right:
//            return [#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)]
//        }
//    }
//
//    func segControl(_segmentedControl: SJFluidSegmentedControl,index:Int){
//
//    }
//
//    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, didScrollWithXOffset offset: CGFloat) {
//        //        let maxOffset = segmentedControl.frame.width / CGFloat(segmentedControl.segmentsCount * (segmentedControl.segmentsCount - 1))
//        //        var width = view.frame.width * 0.2
//        //        var leftDistance = (backgroundScrollView.contentSize.width - width) * 0.2
//        //        var rightDistance = (backgroundScrollView.contentSize.width - width) * 0.8
//        //        let backgroundScrollViewOffset = leftDistance + ((offset / maxOffset) * (backgroundScrollView.contentSize.width - rightDistance - leftDistance))
//        //        width = view.frame.width
//        //        leftDistance = -width * 0.0001 + 10
//        //        rightDistance = width * 0.8
//        //        let skyScrollViewOffset = leftDistance + ((offset / maxOffset) * (skyScrollView.contentSize.width - rightDistance - leftDistance))
//        //        skyScrollView.contentOffset = CGPoint(x: skyScrollViewOffset, y: 0)
//        //        backgroundScrollView.contentOffset = CGPoint(x: backgroundScrollViewOffset, y: 0)
//    }
//
//
//}
