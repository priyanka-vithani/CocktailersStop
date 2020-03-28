//
//  KeyNamesConstants.swift
//  ELFramework
//
//  Created by Admin on 14/12/17.
//  Copyright © 2017 EL. All rights reserved.
//

import Foundation
import UIKit

let APP_DELEGATE = UIApplication.shared.delegate as! AppDelegate

let GetDeviceToken:String = UserDefaultManager.getStringFromUserDefaults(key: kAppDeviceToken)

public let APPNAME :String = "Cocktailers Stop"


public let PlatformName = "2"

let kAppDeviceToken:String = "UDDeviceToken"


//MARK:- Cell IDs

let cell_letters = "letters"
let cell_searchCocktail = "SearchCocktail"
let cell_cocktailDetail = "cocktailDetail"
let cell_instruction = "instructions"
let cell_catList  = "categoryList"
let cell_catFilter = "categoryFilter"
let cell_Ingredients = "IngredientList"
//MARK:- Storyboard IDs

let main = "Main"

//MARK:- View Controller IDs

let vc_tab = "tab"
let vc_login = "LoginVC"
let vc_signup = "SignupVC"
let vc_cocktailDetail = "cocktailDetail"
let vc_preview = "preview"
let vc_catFilter = "categoryFilter"

//MARK:- IMAGE
let PlaceholderImage:UIImage = UIImage.init(named: "logo1")!

//MARK:- NOTIFICATION CENTER NAMES
let NC_DismissPopUp = "NC_DismissPopUp"
let NC_PauseStory  = "NC_PauseStory"

//MARK:- FONT NAMES
let FT_Light = "Roboto-Light"
let FT_Medium = "Roboto-Medium"
let FT_Regular = "Roboto-Regular"
let FT_Bold = "Roboto-Bold"

//MARK:- COLOR NAMES
let themeRedColor = Color_Hex(hex: "#FD1844")
let themeBgColor = Color_Hex(hex: "#F6EAEA")

//MARK:- MESSAGES
let ServerResponseError = "Server Response Error"
let RetryMessage = "Something went wrong please try again..."
let InternetNotAvailable = "Internet connection appears to be offline."
