//
//  CategoryFilterVC.swift
//  CocktailersStop
//
//  Created by ELaunch on 05/02/20.
//  Copyright © 2020 ELaunch. All rights reserved.
//

import UIKit
import CollectionViewSlantedLayout

class CategoryFilterVC: UIViewController {
  
    var urlComponent = ""
    var urlString = ""
    var categoryName = ""
    var arr:[[String:Any]] = []
    @IBOutlet weak var collCategoryFilter: UICollectionView!
    @IBOutlet weak var lblCategoryFilter: UILabel!
    @IBOutlet weak var collCatrgoeyLayout: CollectionViewSlantedLayout!
    override func viewDidLoad() {
        super.viewDidLoad()
        collCatrgoeyLayout.isLastCellExcluded = true
        collCatrgoeyLayout.isFirstCellExcluded = true
        collCatrgoeyLayout.slantingSize = 100
        collCatrgoeyLayout.lineSpacing = 5
        
        urlComponent += categoryName
        lblCategoryFilter.text = categoryName
        api_call()
        
    }
    @IBAction func btnBack_clk(_ sender: Any) {
         
        APP_DELEGATE.appNavigation?.popViewController(animated: true)
    }
    
}
extension CategoryFilterVC{
    func api_call(){
        showHUD()
        if isConnectedToNetwork() == false {
            hideHUD()
            return
        }
        urlString = WS_URL + filterfile + urlComponent
        urlString = urlString.replacingOccurrences(of: " ", with: "%20")
        HttpRequestManager.sharedInstance.getRequest(endpointurl: urlString, service: "", parameters: ["":""], keyname: "", message: "", showLoader: false) { (error, respArr, respDict) in
            if error != nil
            {
                hideHUD()
                return
            }else{
                if respArr != nil{
                    if respArr!.count > 0{
                        self.arr = respArr as! [[String:Any]]
                        hideHUD()
                        self.collCategoryFilter.reloadData()
                        
                    }else{
                        hideHUD()
                        print(respArr!.count)
                    }
                }else{
                    self.arr = []
                    hideHUD()
                    self.collCategoryFilter.reloadData()
                }
                
            }
            
        }
    }
}
extension CategoryFilterVC:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if arr.count == 0{
            self.collCategoryFilter.setEmptyMessage("Sorry, There is nothing to show")
        }else{
            self.collCategoryFilter.restore()
        }
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell_catFilter, for: indexPath) as! CategoryFilterCell
        let temp = arr[indexPath.row]
       
        cell.imgCategory.sd_setImage(with: URL(string: temp["strDrinkThumb"] as! String), placeholderImage: PlaceholderImage)
        cell.lblCategoryFilter.text = (temp["strDrink"] as! String)
        
        if let layout = collectionView.collectionViewLayout as? CollectionViewSlantedLayout {
            cell.contentView.transform = CGAffineTransform(rotationAngle: layout.slantingAngle)
            cell.lblCategoryFilter.transform = cell.contentView.transform
        }
        return cell
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let width = self.collCategoryFilter.frame.width/2-5
//        let height = width + 50
//        return CGSize(width: width, height: height)
//
//
//    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let temp = arr[indexPath.row]
//        let id = temp["idDrink"]
//        let vc = loadVC(strStoryboardId: main, strVCId: vc_cocktailDetail) as! CocktaildetailVC
//        showHUD()
//        vc.cocktilId = id as? String ?? ""
//
//        APP_DELEGATE.appNavigation?.pushViewController(vc, animated: true)
//    }
    
}
extension CategoryFilterVC: CollectionViewDelegateSlantedLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let temp = arr[indexPath.row]
                let id = temp["idDrink"]
                let vc = loadVC(strStoryboardId: main, strVCId: vc_cocktailDetail) as! CocktaildetailVC
                showHUD()
                vc.cocktilId = id as? String ?? ""
        
                APP_DELEGATE.appNavigation?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: CollectionViewSlantedLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGFloat {
        
        
        
        return collectionViewLayout.scrollDirection == .vertical ? 250 : 275
    }
}

extension CategoryFilterVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let collectionView = collCategoryFilter else {return}
        guard let visibleCells = collectionView.visibleCells as? [CategoryFilterCell] else {return}
        for parallaxCell in visibleCells {
            let yOffset = (collectionView.contentOffset.y - parallaxCell.frame.origin.y) / parallaxCell.imageHeight
            let xOffset = (collectionView.contentOffset.x - parallaxCell.frame.origin.x) / parallaxCell.imageWidth
            parallaxCell.offset(CGPoint(x: xOffset * xOffsetSpeed, y: yOffset * yOffsetSpeed))
        }
    }
}
