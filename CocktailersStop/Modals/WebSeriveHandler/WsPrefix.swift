//
//  Constants.swift
//
//  Created by C237 on 30/10/17.
//  Copyright © 2017. All rights reserved.
//

import Foundation
import UIKit

let GET = "GET"
let POST = "POST"
let MEDIA = "MEDIA"

let DEFAULT_TIMEOUT:TimeInterval = 60.0
let Fetch_Data_Limit:NSInteger = 50

//MARK:- API URL
let liveAppUrl = ""
//Soul URL
let URL_Domain = "https://www.thecocktaildb.com"
///https://www.thecocktaildb.com/images/ingredients/Blue%20Curacao-medium.png
//MARK: CorePhp Service URL
let WS_URL = "\(URL_Domain)/api/json/v1/1/"
let WS_IMG_URL = "\(URL_Domain)/images/ingredients/"


//MARK: Image size
let medium = "-Medium.png"

//MARK: Api fileName
let searchfile = "search.php?"
let lookUPfile = "lookup.php?"
let randomfile = "random.php?"
let filterfile = "filter.php?"
let listfile = "list.php?"

//Query String
let queryParamType = "product_type"
let queryParamCategory = "product_category"
let queryParamTags = "product_tags"
let queryParamBrand = "brand"
let queryParamPriceGT = "price_greater_than"
let queryParamPriceLT = "price_less_than"
let queryParamRatingGT = "rating_greater_than"
let queryParamRatingLT = "rating_less_than"

//MARK:- RESPONSE KEY
let kData = "data"
let kMessage = "message"
let kStatus = "success"
let kToken = "token"
let kCode = "code"
let kSecret_log_id = "secret_log_id"

//MARK:- API LOADER MESSAGES
let kProcessing = "Please Wait..."

//MARK:- API SERVICE NAMES
let NoResponseKey = "NoKey"
let ResponseKey = "data"

let APILogin = "login"

