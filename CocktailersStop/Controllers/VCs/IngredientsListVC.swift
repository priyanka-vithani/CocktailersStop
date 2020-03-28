//
//  IngredientsListVC.swift
//  CocktailersStop
//
//  Created by ELaunch on 01/02/20.
//  Copyright © 2020 ELaunch. All rights reserved.
//

import UIKit


class IngredientsListVC: UIViewController {
    
    
    @IBOutlet weak var seatchTxt: UITextField!
    @IBOutlet weak var collIngredients: UICollectionView!
    var isSearching:Bool = false
    var urlString = ""
    var arr:[[String:Any]] = []
    var arrSearch = [[String:Any]]()
    var lbl = UILabel()
    var img = UIImageView()
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        api_calling()
    
    }
    
    
    

}

extension IngredientsListVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        showHUD()
        if TRIM(string: newString).count > 0 {
            let resultPredicate = NSPredicate(format: "self contains[cd] %@", String(newString).trimmed)
            let filtered = self.arr.filter {
                resultPredicate.evaluate(with: $0["strIngredient1"])
            }
            arrSearch = filtered
            self.isSearching = true
        } else {
            if TRIM(string: newString).count == 0 {
                arrSearch = arr
                self.isSearching = false
            }
        }
        hideHUD()
        collIngredients.reloadData()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        seatchTxt.placeholder = ""
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        seatchTxt.placeholder = "Search Ingredients"
    }
}
extension IngredientsListVC{
    func api_calling(){
        showHUD()
        if isConnectedToNetwork() == false {
            hideHUD()
            return
        }
        urlString = WS_URL + listfile + "i=list"
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
                            if !(i["strIngredient1"] is NSNull){
                                self.arr.append(i)
                            }
                        }
                        hideHUD()
                        self.collIngredients.reloadData()
                      
                    }else{
                        hideHUD()
                        print(respArr!.count)
                    }
                }else{
                    self.arr = []
                    hideHUD()
                    self.collIngredients.reloadData()
                }
            }
        }
    }
}
extension IngredientsListVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isSearching ? self.arrSearch.count : self.arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell_Ingredients, for: indexPath)
        img = cell.viewWithTag(154) as! UIImageView
        lbl = cell.viewWithTag(54) as! UILabel
        let temp = isSearching ? arrSearch[indexPath.item] : arr[indexPath.item]
        lbl.text = (temp["strIngredient1"] as! String)
        var imgUrl = WS_IMG_URL + lbl.text!  + medium
        imgUrl = imgUrl.replacingOccurrences(of: " ", with: "%20")
        img.sd_setImage(with: URL(string: imgUrl), placeholderImage: PlaceholderImage)
      
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        lbl = cell?.viewWithTag(54) as! UILabel
        let name = lbl.text
        let vc = loadVC(strStoryboardId: main, strVCId: vc_catFilter) as! CategoryFilterVC
        showHUD()
        vc.urlComponent = "i="
        vc.categoryName = name ?? ""
        APP_DELEGATE.appNavigation?.pushViewController(vc, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.collIngredients.frame.width/3 - 5
        let height = width + 100
        return CGSize(width: width, height: height)
    }
    
    
    
}

