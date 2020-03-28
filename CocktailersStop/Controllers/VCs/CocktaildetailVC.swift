//
//  CocktaildetailVC.swift
//  CocktailersStop
//
//  Created by ELaunch on 05/02/20.
//  Copyright © 2020 ELaunch. All rights reserved.
//

import UIKit
import AMTagListView


class CocktaildetailVC: UIViewController {

    var cocktilId = ""
    var urlString = ""
    var arr = [Drinks]()
    var arrTag = [String]()
    var ArrIngredients : [String] = []
    var ArrMeasures : [String] = []
   
   
    @IBOutlet weak var tblHeader: UIView!
    @IBOutlet weak var tbl: UITableView!
    @IBOutlet weak var CVIngredients: UICollectionView!
    @IBOutlet weak var tagView: AMTagListView!
    @IBOutlet weak var nlsTagVwHeight: NSLayoutConstraint!
    @IBOutlet weak var lblCocktailName: UILabel!
    @IBOutlet weak var imgCocktail: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api_call()
    }
    func setupTagUI(){
        
        AMTagView.appearance().tagLength = 10
        AMTagView.appearance().textPadding = CGPoint(x: 14, y: 14)
        AMTagView.appearance().textFont = UIFont(name: "Futura", size: 14)
        AMTagView.appearance().tagColor = themeRedColor
        for i in arr{
         
            let tag = i.strTags
            arrTag = (tag?.components(separatedBy: ","))!
            if arrTag != [""]{
                for tag in arrTag{
                    tagView.addTag(tag)
                }
            }else{
                arrTag.removeAll()
                if (i.strCategory != "") {
                     arrTag.append(i.strCategory)
                }
                if i.strIBA != ""{
                    arrTag.append("IBA")
                    arrTag.append(i.strIBA)
                }
                if i.strAlcoholic != ""{
                     arrTag.append(i.strAlcoholic)
                }
                
                for tag in arrTag{
                    tagView.addTag(tag)
                }
            }
        }
    }
    @IBAction func btnBack_clk(_ sender: Any) {
        APP_DELEGATE.appNavigation?.popViewController(animated: true)
    }
}
extension CocktaildetailVC{
    func api_call(){
        showHUD()
        if isConnectedToNetwork() == false {
            hideHUD()
            return
        }
        urlString = WS_URL + lookUPfile + "i=" + cocktilId
        urlString = urlString.replacingOccurrences(of: " ", with: "%20")
        print(urlString)
        HttpRequestManager.sharedInstance.getRequest(endpointurl: urlString, service: "Drinks", parameters: ["":""], keyname: "Drinks", message: "", showLoader: false) { (error, respArr, respDict) in
            if error != nil
            {
                hideHUD()
                return
            }else{
                if respArr != nil{
                    if respArr!.count > 0{
                        self.arr = respArr as! [Drinks]
                        self.setupTagUI()
                        for i in self.arr{
                            self.lblCocktailName.text = i.strDrink
                          
                            
                            self.imgCocktail.sd_setImage(with: URL(string: i.strDrinkThumb), placeholderImage: PlaceholderImage)
                            let tap = UITapGestureRecognizer(target: self, action: #selector(self.handle))
                            self.imgCocktail.isUserInteractionEnabled = true
                            self.imgCocktail.addGestureRecognizer(tap)
                            
                        }
                        self.ingredientsList()
                        self.measureList()
                        hideHUD()
                         self.tbl.reloadData()
                        self.CVIngredients.reloadData()
                        
                    }else{
                        hideHUD()
                        print(respArr!.count)
                    }
                }else{
                    self.arr = []
                    hideHUD()
                    self.tbl.reloadData()
                self.CVIngredients.reloadData()
                }
            }
        }
    }
    @objc func handle(sender : UITapGestureRecognizer){
        let vc = loadVC(strStoryboardId: main, strVCId: vc_preview) as! ImagePreviewVC
        vc.img = imgCocktail.image!
        vc.name = lblCocktailName.text!
        APP_DELEGATE.appNavigation?.pushViewController(vc, animated: true)
    }
    func ingredientsList(){
        for i in arr{
            ArrIngredients.append(i.strIngredient1)
            ArrIngredients.append(i.strIngredient2)
             ArrIngredients.append(i.strIngredient3)
             ArrIngredients.append(i.strIngredient4)
             ArrIngredients.append(i.strIngredient5)
             ArrIngredients.append(i.strIngredient6)
            ArrIngredients.append(i.strIngredient7)
            ArrIngredients.append(i.strIngredient8)
            ArrIngredients.append(i.strIngredient9)
            ArrIngredients.append(i.strIngredient10)
            ArrIngredients.append(i.strIngredient11)
            ArrIngredients.append(i.strIngredient12)
            ArrIngredients.append(i.strIngredient13)
            ArrIngredients.append(i.strIngredient14)
            ArrIngredients.append(i.strIngredient15)
        }
      ArrIngredients = ArrIngredients.filter({ $0 != "" })
    }
    func measureList(){
        for i in arr{
            ArrMeasures.append(i.strMeasure1)
            ArrMeasures.append(i.strMeasure2)
            ArrMeasures.append(i.strMeasure3)
            ArrMeasures.append(i.strMeasure4)
            ArrMeasures.append(i.strMeasure5)
            ArrMeasures.append(i.strMeasure6)
            ArrMeasures.append(i.strMeasure7)
            ArrMeasures.append(i.strMeasure8)
            ArrMeasures.append(i.strMeasure9)
            ArrMeasures.append(i.strMeasure10)
            ArrMeasures.append(i.strMeasure11)
            ArrMeasures.append(i.strMeasure12)
            ArrMeasures.append(i.strMeasure13)
            ArrMeasures.append(i.strMeasure14)
            ArrMeasures.append(i.strMeasure15)
        }
    }
}
extension CocktaildetailVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ArrIngredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cell_cocktailDetail, indexPath: indexPath) as! CocktailDetailCell
        let tempIng = ArrIngredients[indexPath.row]
        let tempMes = ArrMeasures[indexPath.row]
        cell.lblIngredients.text = tempMes + " " + tempIng
        var url = WS_IMG_URL + tempIng + medium
        url = url.replacingOccurrences(of: " ", with: "%20")
        cell.imgIngredients.sd_setImage(with: URL(string: url), placeholderImage: PlaceholderImage)
     
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if ArrIngredients.count == 1{
            let width = self.CVIngredients.frame.width
            let height = self.CVIngredients.frame.height
            return CGSize(width: width, height: height)
        }else{
            let width = self.CVIngredients.frame.width/3 - 5
            let height : CGFloat = width + 100
            return CGSize(width: width, height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let name = ArrIngredients[indexPath.row]
        let vc = loadVC(strStoryboardId: main, strVCId: vc_catFilter) as! CategoryFilterVC
        showHUD()
        vc.urlComponent = "i="
        vc.categoryName = name 
        APP_DELEGATE.appNavigation?.pushViewController(vc, animated: true)
    }
    
}


extension CocktaildetailVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_instruction, for: indexPath) as! CocktailInstructionCell
        let temp = arr[indexPath.row]
        cell.lblInstruction.text = temp.strInstructions
        cell.lblGlassType.text = "Serve: " + temp.strGlass
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tbl.estimatedRowHeight
    }
    
}





