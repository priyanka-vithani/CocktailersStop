//
//  UtilityFunctions.swift
//  Makeupholic
//
//  Created by MAC on 15/07/19.
//  Copyright © 2019 Payal. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration
let loadercolor = [UIColor.white,themeRedColor,UIColor.lightGray] /*[Color_Hex(hex: "#eb1f20"),
 Color_Hex(hex: "#ffae00")]*/
var spinner = RPLoadingAnimationView.init(frame: CGRect.zero)
var overlayView = UIView()
var hudLabel = UILabel.init(frame: CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: SCREENWIDTH(), height: 50)))
var hudText: String = ""{
    didSet{
        hudLabel.text = hudText
    }
}
public func SCREENWIDTH() -> CGFloat
{
    let screenSize = UIScreen.main.bounds
    return screenSize.width
}

public func SCREENHEIGHT() -> CGFloat
{
    let screenSize = UIScreen.main.bounds
    return screenSize.height
}
public func getStoryboard(storyboardName: String) -> UIStoryboard {
    return UIStoryboard(name: storyboardName, bundle: nil)
}

public func loadVC(strStoryboardId: String, strVCId: String) -> UIViewController {
    
    let vc = getStoryboard(storyboardName: strStoryboardId).instantiateViewController(withIdentifier: strVCId)
    return vc
}
public var appDisplayName: String? {
    return Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String
}
public var appBundleID: String? {
    return Bundle.main.bundleIdentifier
}
public func IOS_VERSION() -> String {
    return UIDevice.current.systemVersion
}
public var statusBarHeight: CGFloat {
    return UIApplication.shared.statusBarFrame.height
}
public var applicationIconBadgeNumber: Int {
    get {
        return UIApplication.shared.applicationIconBadgeNumber
    }
    set {
        UIApplication.shared.applicationIconBadgeNumber = newValue
    }
}
public func ShowNetworkIndicator(xx :Bool)
{
    runOnMainThreadWithoutDeadlock {
        UIApplication.shared.isNetworkActivityIndicatorVisible = xx
    }
}
public func TRIM(string: Any) -> String
{
    return (string as AnyObject).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
}
func isConnectedToNetwork() -> Bool
{
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    })
        else
    {
        return false
    }
    
    var flags : SCNetworkReachabilityFlags = []
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
        return false
    }
    
    let isReachable = flags.contains(.reachable)
    let needsConnection = flags.contains(.connectionRequired)
    let available =  (isReachable && !needsConnection)
    if(available)
    {
        return true
    }
    else
    {
        //showMessage(InternetNotAvailable)
        return false
    }
}
public var mostTopViewController: UIViewController? {
    get {
        let mostTop = UIApplication.shared.keyWindow?.rootViewController
        if let mostTopPresented = mostTop?.presentedViewController{
            return mostTopPresented
        }
        return mostTop
    }
    set {
        UIApplication.shared.keyWindow?.rootViewController = newValue
    }
}
public func FontWithSize(_ fname: String,_ fsize: Int) -> UIFont
{
    return UIFont(name: fname, size: CGFloat(fsize))!
}

//MARK:- Color
public func Color_RGBA(_ R: Int,_ G: Int,_ B: Int,_ A: Int) -> UIColor
{
    return UIColor(red: CGFloat(R)/255.0, green: CGFloat(G)/255.0, blue: CGFloat(B)/255.0, alpha :CGFloat(A))
}
public func RGBA(_ R: Int,_ G: Int,_ B: Int,_ A: CGFloat) -> UIColor
{
    return UIColor(red: CGFloat(R)/255.0, green: CGFloat(G)/255.0, blue: CGFloat(B)/255.0, alpha :A)
}
public func Color_Hex(hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
public func createGradientLayer(view:UIView,colorset:[UIColor],framerect:CGRect)
{
    let layer = CAGradientLayer()
    layer.frame = framerect
    layer.colors = colorset
    view.layer.addSublayer(layer)
}
public func showHUD()
{
    DispatchQueue.main.async {
        spinner.removeFromSuperview()
        overlayView.removeFromSuperview()
        overlayView.frame = (mostTopViewController?.view)!.frame
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        spinner = RPLoadingAnimationView(
            frame: CGRect(origin: CGPoint.zero, size: UIScreen.main.bounds.size),
            type: .linescale,
            colors: loadercolor,
            size: CGSize.init(width: 48, height: 75)
        )
        overlayView.addSubview(spinner)
        if hudText.count > 0
        {
            hudLabel.frame = overlayView.frame
            hudLabel.center = overlayView.center
            hudLabel.frame.origin.y = overlayView.frame.center.y + 20
            hudLabel.frame.size.height = 50
            hudLabel.textAlignment = .center
            hudLabel.font = UIFont.init(name: FT_Medium, size: 14)
            hudLabel.textColor = UIColor.white
            hudLabel.text = hudText
            overlayView.addSubview(hudLabel)
        }
        APP_DELEGATE.window?.addSubview(overlayView)
        spinner.setupAnimation()
    }
}

public func hideHUD()
{
    DispatchQueue.main.async {
        spinner.removeFromSuperview()
        overlayView.removeFromSuperview()
        hudText = ""
    }
}
public func convertStringToDictionary(str:String) -> [String: Any]? {
    //let strDecodeMess : String = str.base64Decoded!
    //if let data = strDecodeMess.data(using: .utf8) {
    if let data = str.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}
public func hideLoaderHUD()
{
    
}
func removeFileFromLocal(_ filename: String) {
    let fileManager = FileManager.default
    let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    let filePath = URL(fileURLWithPath: documentsPath).appendingPathComponent(filename).absoluteString
    
    do{
        try fileManager.removeItem(atPath: filePath)
    }
    catch{
        //print("Could not delete file -:\(error.localizedDescription) ")
    }
}
func arrayBrandNames() -> [String]
{
    return ["almay","alva","anna sui","annabelle","benefit","boosh","burt's bees","butter london","c'est moi","cargo cosmetics","china glaze","clinique","coastal classic creation","colourpop","covergirl","dalish","deciem","dior","dr. hauschka","e.l.f.","essie","fenty","glossier","green people","iman","l'oreal","lotus cosmetics usa","maia's mineral galaxy","marcelle","marienatie","maybelline","milani","mineral fusion","misa","mistura","moov","nudus","nyx","orly","pacifica","penny lane organics","physicians formula","piggy paint","pure anada","rejuva minerals","revlon","sally b's skin yummies","salon perfect","sante","sinful colours","smashbox","stila","suncoat","w3llpeople","wet n wild","zorah","ultima ||"]
}
func arrayBrandLogos() -> [String]
{
    return ["almay","alva","annasui","annabelle","benefit","boosh","burtbees","butterlondon","cestmoi","cargo","chinaglaze","clinique","coastal","colourpop","covergirl","dalish","deciem","dior","drhauschka","eif","essie","fenty","glossier","greenpeople","iman","loreal","lotus","maiasmineralgalaxy","marcelle","marienatie","maybelline","milani","mineralfusion","misa","mistura","moov","nudus","nyx","orly","pacifica","pennylane","physiciansformula","piggypaint","pureanadaa","rajuva","revlon","sallyyummies","salonperfec","sante","sinfulcolours","smashbox","stila","suncoat","well3peoples","wetild","zorah","ultima"]
}

func arrayTagList() -> [String]
{
     return ["Canadian",
    "CertClean",
    "Chemical Free",
    "Dairy Free",
    "EWG Verified",
    "EcoCert",
    "Fair Trade",
    "Gluten Free",
    "Hypoallergenic",
    "Natural",
    "No Talc",
    "Non-GMO",
    "Organic",
    "Peanut Free Product",
    "Sugar Free",
    "USDA Organic",
    "Vegan",
    "alcohol free",
    "cruelty free",
    "oil free",
    "purpicks",
    "silicone free",
    "water free"]
}
func arrayTagColorList() -> [UIColor]
{
    return [Color_Hex(hex: "0048BA"),Color_Hex(hex: "B0BF1A")
    ,Color_Hex(hex: "800000"),Color_Hex(hex: "000080"),Color_Hex(hex: "800080"),Color_Hex(hex: "00FFFF"),Color_Hex(hex: "B22222"),Color_Hex(hex: "4682B4"),Color_Hex(hex: "008080"),Color_Hex(hex: "6B8E23"),Color_Hex(hex: "DAA520"),Color_Hex(hex: "C46210"),Color_Hex(hex: "FF7F50"),Color_Hex(hex: "FF8C00"),Color_Hex(hex: "B284BE"),Color_Hex(hex: "BC8F8F"),Color_Hex(hex: "EE82EE"),Color_Hex(hex: "E52B50"),Color_Hex(hex: "70C405"),Color_Hex(hex: "FF8C00"),Color_Hex(hex: "F19CBB"),Color_Hex(hex: "7FFFD4"),Color_Hex(hex: "DC143C")]
}

func arrayTypes() -> [structProductMetaData]
{
    var finalarr = [structProductMetaData]()
    var mdata = structProductMetaData.init(productname: "Foundation", productimg:"foundation" , productcategory: ["All category","Liquid","Contour","Bb cc","Concealer","Cream","Mineral","Powder","Highlighter"], producttag: ["Vegan","Canadian","Natural","Gluten free","Certclean","Purpicks","No talc","Hypoallergenic","Ewg verified","Silicone free","Oil free","Alcohol free","Cruelty free","Water free"])
    finalarr.append(mdata)
    mdata = structProductMetaData.init(productname: "Mascara",productimg:"mascara" ,  productcategory: ["Pencil"], producttag: ["Gluten free","Natural","Vegan","Canadian","Organic","No talc","Hypoallergenic","Ewg verified","Purpicks","Ecocert","Usda organic","Certclean"])
    finalarr.append(mdata)
    
    mdata = structProductMetaData.init(productname: "Lipstick", productimg:"lipstick" , productcategory: ["All category","Lipstick","Lip gloss","Liquid","Lip stain"], producttag: ["Canadian","Natural","Peanut free product","Non-gmo","Gluten free","Vegan","Organic","Certclean","Purpicks","No talc","Hypoallergenic","Ewg verified","Chemical free","Cruelty free"])
    finalarr.append(mdata)
  
    mdata = structProductMetaData.init(productname: "Eyeliner", productimg:"eyeliner" , productcategory: ["All category","Liquid","Pencil","Gel","Cream"], producttag: ["Vegan","Canadian","Natural","Gluten free","Organic","Certclean","Purpicks","No talc","Hypoallergenic","Ewg verified","Ecocert"])
    finalarr.append(mdata)
    mdata = structProductMetaData.init(productname: "Eyeshadow",productimg:"eyeshadow" ,  productcategory: ["All category","Palette","Pencil","Cream"], producttag: ["Vegan","Canadian","Gluten free","Natural","Non-gmo","Certclean","Purpicks","Organic","Ewg verified","Usda organic","No talc","Hypoallergenic","Ecocert"])
    finalarr.append(mdata)
    mdata = structProductMetaData.init(productname: "Blush",productimg:"blush" , productcategory: ["All category","Powder","Cream"], producttag: ["Vegan","Gluten free","Canadian","Natural","Non-gmo","Organic","Usda organic","Purpicks","Certclean","No talc","Hypoallergenic","Ewg verified"])
    finalarr.append(mdata)
    mdata = structProductMetaData.init(productname: "Bronzer",productimg:"bronzer" ,  productcategory: ["Powder"], producttag: ["Gluten free","Canadian","Natural","Organic","Vegan","Ewg verified","Purpicks"])
    finalarr.append(mdata)
    
    mdata = structProductMetaData.init(productname: "Eyebrow",productimg:"eyebrow" , productcategory: ["Pencil"], producttag: ["Ewg verified","Purpicks"])
    finalarr.append(mdata)
    mdata = structProductMetaData.init(productname: "Nail polish", productimg:"nailpolish" , productcategory: ["Liquid"], producttag: ["Vegan","Canadian","Natural","Dairy free","Non-gmo","Sugar free","Fair trade","Gluten free"])
    
    finalarr.append(mdata)
    mdata = structProductMetaData.init(productname: "Lip liner", productimg:"lipliner" , productcategory: ["Pencil"], producttag: ["Natural","Vegan","Gluten free","Canadian","No talc","Hypoallergenic","Ewg verified","Purpicks","Cruelty free"])
    finalarr.append(mdata)
    return finalarr
}
