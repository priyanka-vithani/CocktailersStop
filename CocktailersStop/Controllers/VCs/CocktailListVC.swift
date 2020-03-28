//
//  SearchCocktailVC.swift
//  CocktailersStop
//
//  Created by ELaunch on 01/02/20.
//  Copyright © 2020 ELaunch. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire
import SwiftyJSON

class CocktailListVC: UIViewController {
    
    
    @IBOutlet weak var collAlphabat: UICollectionView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var collCocktails: UICollectionView!
    
    var isSearching:Bool = false
    var arr = [Drinks]()
    var arrSearch = [Drinks]()
    var cocktailName = String()
    var urlString = "" //"https://www.thecocktaildb.com/api/json/v1/1/search.php?f=a"
    var letters = [Character]()
    var alphabat = "a"
    var lbl = UILabel()
    var prevSelevtedRow:Int = 0
    var currSelectedRow:Int = 0
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtSearch.delegate = self
        collAlphabat.delegate = self
        collAlphabat.dataSource = self
        collCocktails.dataSource = self
        collCocktails.delegate = self
       // arrSearch = arr
        api_search()
        generateAlphabat()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        collAlphabat.reloadData()
    }
    
    @IBAction func btnSearch_clk(_ sender: Any) {
    }
    
   
    
}
extension CocktailListVC:UITextFieldDelegate{
    
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
                resultPredicate.evaluate(with: $0.strDrink)
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
        collCocktails.reloadData()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        txtSearch.placeholder = ""
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        txtSearch.placeholder = "Search Cocktail"
    }
    
}
extension CocktailListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 2{
            print(letters.count)
            return letters.count
        }else{
            if arr.count == 0{
                self.collCocktails.setEmptyMessage("Sorry, There is nothing from '\(alphabat)'")
            }else{
                self.collCocktails.restore()
            }
            return isSearching ? self.arrSearch.count : self.arr.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 2{
            let cell = collectionView.dequeueCell(cell_letters, indexPath: indexPath)
            lbl = cell.viewWithTag(50) as! UILabel
            lbl.text = "\(letters[indexPath.item])"
            
            if (currSelectedRow == indexPath.item){
                print(currSelectedRow)
                
                lbl.backgroundColor = themeRedColor
                lbl.textColor = .white
            }else{
                lbl.backgroundColor = .clear
            }
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell_searchCocktail, for: indexPath) as! SearchCocktailCell
            print(arr)
            let temp = isSearching ? arrSearch[indexPath.item] : arr[indexPath.item]
            cell.imgCocktail.sd_setImage(with: URL(string: temp.strDrinkThumb), placeholderImage: PlaceholderImage)
            cell.lblCocktailName.text = temp.strDrink
            return cell
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 2{
            
            let cell = collectionView.cellForItem(at: indexPath)
            alphabat = "\(letters[indexPath.item].lowercased())"
            lbl = cell?.viewWithTag(50) as! UILabel
            
            prevSelevtedRow = currSelectedRow
            currSelectedRow = indexPath.row
            
            self.collAlphabat.reloadItems(at: [IndexPath.init(item: currSelectedRow, section: 0),IndexPath.init(item: prevSelevtedRow, section: 0)])
            api_search()
            
            
        }else{
            
            let temp = isSearching ? arrSearch[indexPath.item] : arr[indexPath.item]
            let id = temp.idDrink
            let vc = loadVC(strStoryboardId: main, strVCId: vc_cocktailDetail) as! CocktaildetailVC
            showHUD()
            vc.cocktilId = id ?? ""
            
            APP_DELEGATE.appNavigation?.pushViewController(vc, animated: true)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 2{
            let width = 25
            let height = width
            
            return CGSize(width: width, height: height)
        }else{
            let width = self.collCocktails.frame.width/2-5
            
            let height = width + 50
            
            return CGSize(width: width, height: height)
        }
    }
}
extension CocktailListVC
{
    func generateAlphabat(){
        let aScalars = "A".unicodeScalars
        let aCode = aScalars[aScalars.startIndex].value
        
        letters = (0..<26).map {
            i in Character(UnicodeScalar(aCode + i)!)
        }
        print(letters)
    }
    func api_search(){
        showHUD()
        if isConnectedToNetwork() == false {
            hideHUD()
            return
        }
        urlString = WS_URL + searchfile + "f=" + alphabat
        urlString = urlString.replacingOccurrences(of: " ", with: "%20")
        HttpRequestManager.sharedInstance.getRequest(endpointurl: urlString, service: "Drinks", parameters: ["":""], keyname: "Drinks", message: "", showLoader: false) { (error, respArr, respDict) in
            if error != nil
            {
                hideHUD()
                return
            }else{
                if respArr != nil{
                    if respArr!.count > 0{
                        self.arr = respArr as! [Drinks]
                        hideHUD()
                        self.collCocktails.reloadData()
                        
                    }else{
                        hideHUD()
                        print(respArr!.count)
                    }
                }else{
                    self.arr = []
                    hideHUD()
                    self.collCocktails.reloadData()
                }
            }
        }
    }
}

