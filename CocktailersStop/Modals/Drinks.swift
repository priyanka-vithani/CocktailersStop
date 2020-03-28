//
//  Drinks.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on February 3, 2020

import Foundation
import SwiftyJSON


class Drinks : NSObject, NSCoding{

    var dateModified : String!
    var idDrink : String!
    var strAlcoholic : String!
    var strCategory : String!
    var strCreativeCommonsConfirmed : String!
    var strDrink : String!
    var strDrinkAlternate : String!
    var strDrinkDE : String!
    var strDrinkES : String!
    var strDrinkFR : String!
    var strDrinkThumb : String!
    var strDrinkZHHANS : String!
    var strDrinkZHHANT : String!
    var strGlass : String!
    var strIBA : String!
    var strIngredient1 : String!
    var strIngredient10 : String!
    var strIngredient11 : String!
    var strIngredient12 : String!
    var strIngredient13 : String!
    var strIngredient14 : String!
    var strIngredient15 : String!
    var strIngredient2 : String!
    var strIngredient3 : String!
    var strIngredient4 : String!
    var strIngredient5 : String!
    var strIngredient6 : String!
    var strIngredient7 : String!
    var strIngredient8 : String!
    var strIngredient9 : String!
    var strInstructions : String!
    var strInstructionsDE : String!
    var strInstructionsES : String!
    var strInstructionsFR : String!
    var strInstructionsZHHANS : String!
    var strInstructionsZHHANT : String!
    var strMeasure1 : String!
    var strMeasure10 : String!
    var strMeasure11 : String!
    var strMeasure12 : String!
    var strMeasure13 : String!
    var strMeasure14 : String!
    var strMeasure15 : String!
    var strMeasure2 : String!
    var strMeasure3 : String!
    var strMeasure4 : String!
    var strMeasure5 : String!
    var strMeasure6 : String!
    var strMeasure7 : String!
    var strMeasure8 : String!
    var strMeasure9 : String!
    var strTags : String!
    var strVideo : String!

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
        dateModified = json["dateModified"].stringValue
        idDrink = json["idDrink"].stringValue
        strAlcoholic = json["strAlcoholic"].stringValue
        strCategory = json["strCategory"].stringValue
        strCreativeCommonsConfirmed = json["strCreativeCommonsConfirmed"].stringValue
        strDrink = json["strDrink"].stringValue
        strDrinkAlternate = json["strDrinkAlternate"].stringValue
        strDrinkDE = json["strDrinkDE"].stringValue
        strDrinkES = json["strDrinkES"].stringValue
        strDrinkFR = json["strDrinkFR"].stringValue
        strDrinkThumb = json["strDrinkThumb"].stringValue
        strDrinkZHHANS = json["strDrinkZH-HANS"].stringValue
        strDrinkZHHANT = json["strDrinkZH-HANT"].stringValue
        strGlass = json["strGlass"].stringValue
        strIBA = json["strIBA"].stringValue
        strIngredient1 = json["strIngredient1"].stringValue
        strIngredient10 = json["strIngredient10"].stringValue
        strIngredient11 = json["strIngredient11"].stringValue
        strIngredient12 = json["strIngredient12"].stringValue
        strIngredient13 = json["strIngredient13"].stringValue
        strIngredient14 = json["strIngredient14"].stringValue
        strIngredient15 = json["strIngredient15"].stringValue
        strIngredient2 = json["strIngredient2"].stringValue
        strIngredient3 = json["strIngredient3"].stringValue
        strIngredient4 = json["strIngredient4"].stringValue
        strIngredient5 = json["strIngredient5"].stringValue
        strIngredient6 = json["strIngredient6"].stringValue
        strIngredient7 = json["strIngredient7"].stringValue
        strIngredient8 = json["strIngredient8"].stringValue
        strIngredient9 = json["strIngredient9"].stringValue
        strInstructions = json["strInstructions"].stringValue
        strInstructionsDE = json["strInstructionsDE"].stringValue
        strInstructionsES = json["strInstructionsES"].stringValue
        strInstructionsFR = json["strInstructionsFR"].stringValue
        strInstructionsZHHANS = json["strInstructionsZH-HANS"].stringValue
        strInstructionsZHHANT = json["strInstructionsZH-HANT"].stringValue
        strMeasure1 = json["strMeasure1"].stringValue
        strMeasure10 = json["strMeasure10"].stringValue
        strMeasure11 = json["strMeasure11"].stringValue
        strMeasure12 = json["strMeasure12"].stringValue
        strMeasure13 = json["strMeasure13"].stringValue
        strMeasure14 = json["strMeasure14"].stringValue
        strMeasure15 = json["strMeasure15"].stringValue
        strMeasure2 = json["strMeasure2"].stringValue
        strMeasure3 = json["strMeasure3"].stringValue
        strMeasure4 = json["strMeasure4"].stringValue
        strMeasure5 = json["strMeasure5"].stringValue
        strMeasure6 = json["strMeasure6"].stringValue
        strMeasure7 = json["strMeasure7"].stringValue
        strMeasure8 = json["strMeasure8"].stringValue
        strMeasure9 = json["strMeasure9"].stringValue
        strTags = json["strTags"].stringValue
        strVideo = json["strVideo"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
        if dateModified != nil{
        	dictionary["dateModified"] = dateModified
        }
        if idDrink != nil{
        	dictionary["idDrink"] = idDrink
        }
        if strAlcoholic != nil{
        	dictionary["strAlcoholic"] = strAlcoholic
        }
        if strCategory != nil{
        	dictionary["strCategory"] = strCategory
        }
        if strCreativeCommonsConfirmed != nil{
        	dictionary["strCreativeCommonsConfirmed"] = strCreativeCommonsConfirmed
        }
        if strDrink != nil{
        	dictionary["strDrink"] = strDrink
        }
        if strDrinkAlternate != nil{
        	dictionary["strDrinkAlternate"] = strDrinkAlternate
        }
        if strDrinkDE != nil{
        	dictionary["strDrinkDE"] = strDrinkDE
        }
        if strDrinkES != nil{
        	dictionary["strDrinkES"] = strDrinkES
        }
        if strDrinkFR != nil{
        	dictionary["strDrinkFR"] = strDrinkFR
        }
        if strDrinkThumb != nil{
        	dictionary["strDrinkThumb"] = strDrinkThumb
        }
        if strDrinkZHHANS != nil{
        	dictionary["strDrinkZH-HANS"] = strDrinkZHHANS
        }
        if strDrinkZHHANT != nil{
        	dictionary["strDrinkZH-HANT"] = strDrinkZHHANT
        }
        if strGlass != nil{
        	dictionary["strGlass"] = strGlass
        }
        if strIBA != nil{
        	dictionary["strIBA"] = strIBA
        }
        if strIngredient1 != nil{
        	dictionary["strIngredient1"] = strIngredient1
        }
        if strIngredient10 != nil{
        	dictionary["strIngredient10"] = strIngredient10
        }
        if strIngredient11 != nil{
        	dictionary["strIngredient11"] = strIngredient11
        }
        if strIngredient12 != nil{
        	dictionary["strIngredient12"] = strIngredient12
        }
        if strIngredient13 != nil{
        	dictionary["strIngredient13"] = strIngredient13
        }
        if strIngredient14 != nil{
        	dictionary["strIngredient14"] = strIngredient14
        }
        if strIngredient15 != nil{
        	dictionary["strIngredient15"] = strIngredient15
        }
        if strIngredient2 != nil{
        	dictionary["strIngredient2"] = strIngredient2
        }
        if strIngredient3 != nil{
        	dictionary["strIngredient3"] = strIngredient3
        }
        if strIngredient4 != nil{
        	dictionary["strIngredient4"] = strIngredient4
        }
        if strIngredient5 != nil{
        	dictionary["strIngredient5"] = strIngredient5
        }
        if strIngredient6 != nil{
        	dictionary["strIngredient6"] = strIngredient6
        }
        if strIngredient7 != nil{
        	dictionary["strIngredient7"] = strIngredient7
        }
        if strIngredient8 != nil{
        	dictionary["strIngredient8"] = strIngredient8
        }
        if strIngredient9 != nil{
        	dictionary["strIngredient9"] = strIngredient9
        }
        if strInstructions != nil{
        	dictionary["strInstructions"] = strInstructions
        }
        if strInstructionsDE != nil{
        	dictionary["strInstructionsDE"] = strInstructionsDE
        }
        if strInstructionsES != nil{
        	dictionary["strInstructionsES"] = strInstructionsES
        }
        if strInstructionsFR != nil{
        	dictionary["strInstructionsFR"] = strInstructionsFR
        }
        if strInstructionsZHHANS != nil{
        	dictionary["strInstructionsZH-HANS"] = strInstructionsZHHANS
        }
        if strInstructionsZHHANT != nil{
        	dictionary["strInstructionsZH-HANT"] = strInstructionsZHHANT
        }
        if strMeasure1 != nil{
        	dictionary["strMeasure1"] = strMeasure1
        }
        if strMeasure10 != nil{
        	dictionary["strMeasure10"] = strMeasure10
        }
        if strMeasure11 != nil{
        	dictionary["strMeasure11"] = strMeasure11
        }
        if strMeasure12 != nil{
        	dictionary["strMeasure12"] = strMeasure12
        }
        if strMeasure13 != nil{
        	dictionary["strMeasure13"] = strMeasure13
        }
        if strMeasure14 != nil{
        	dictionary["strMeasure14"] = strMeasure14
        }
        if strMeasure15 != nil{
        	dictionary["strMeasure15"] = strMeasure15
        }
        if strMeasure2 != nil{
        	dictionary["strMeasure2"] = strMeasure2
        }
        if strMeasure3 != nil{
        	dictionary["strMeasure3"] = strMeasure3
        }
        if strMeasure4 != nil{
        	dictionary["strMeasure4"] = strMeasure4
        }
        if strMeasure5 != nil{
        	dictionary["strMeasure5"] = strMeasure5
        }
        if strMeasure6 != nil{
        	dictionary["strMeasure6"] = strMeasure6
        }
        if strMeasure7 != nil{
        	dictionary["strMeasure7"] = strMeasure7
        }
        if strMeasure8 != nil{
        	dictionary["strMeasure8"] = strMeasure8
        }
        if strMeasure9 != nil{
        	dictionary["strMeasure9"] = strMeasure9
        }
        if strTags != nil{
        	dictionary["strTags"] = strTags
        }
        if strVideo != nil{
        	dictionary["strVideo"] = strVideo
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
		dateModified = aDecoder.decodeObject(forKey: "dateModified") as? String
		idDrink = aDecoder.decodeObject(forKey: "idDrink") as? String
		strAlcoholic = aDecoder.decodeObject(forKey: "strAlcoholic") as? String
		strCategory = aDecoder.decodeObject(forKey: "strCategory") as? String
		strCreativeCommonsConfirmed = aDecoder.decodeObject(forKey: "strCreativeCommonsConfirmed") as? String
		strDrink = aDecoder.decodeObject(forKey: "strDrink") as? String
		strDrinkAlternate = aDecoder.decodeObject(forKey: "strDrinkAlternate") as? String
		strDrinkDE = aDecoder.decodeObject(forKey: "strDrinkDE") as? String
		strDrinkES = aDecoder.decodeObject(forKey: "strDrinkES") as? String
		strDrinkFR = aDecoder.decodeObject(forKey: "strDrinkFR") as? String
		strDrinkThumb = aDecoder.decodeObject(forKey: "strDrinkThumb") as? String
		strDrinkZHHANS = aDecoder.decodeObject(forKey: "strDrinkZH-HANS") as? String
		strDrinkZHHANT = aDecoder.decodeObject(forKey: "strDrinkZH-HANT") as? String
		strGlass = aDecoder.decodeObject(forKey: "strGlass") as? String
		strIBA = aDecoder.decodeObject(forKey: "strIBA") as? String
		strIngredient1 = aDecoder.decodeObject(forKey: "strIngredient1") as? String
		strIngredient10 = aDecoder.decodeObject(forKey: "strIngredient10") as? String
		strIngredient11 = aDecoder.decodeObject(forKey: "strIngredient11") as? String
		strIngredient12 = aDecoder.decodeObject(forKey: "strIngredient12") as? String
		strIngredient13 = aDecoder.decodeObject(forKey: "strIngredient13") as? String
		strIngredient14 = aDecoder.decodeObject(forKey: "strIngredient14") as? String
		strIngredient15 = aDecoder.decodeObject(forKey: "strIngredient15") as? String
		strIngredient2 = aDecoder.decodeObject(forKey: "strIngredient2") as? String
		strIngredient3 = aDecoder.decodeObject(forKey: "strIngredient3") as? String
		strIngredient4 = aDecoder.decodeObject(forKey: "strIngredient4") as? String
		strIngredient5 = aDecoder.decodeObject(forKey: "strIngredient5") as? String
		strIngredient6 = aDecoder.decodeObject(forKey: "strIngredient6") as? String
		strIngredient7 = aDecoder.decodeObject(forKey: "strIngredient7") as? String
		strIngredient8 = aDecoder.decodeObject(forKey: "strIngredient8") as? String
		strIngredient9 = aDecoder.decodeObject(forKey: "strIngredient9") as? String
		strInstructions = aDecoder.decodeObject(forKey: "strInstructions") as? String
		strInstructionsDE = aDecoder.decodeObject(forKey: "strInstructionsDE") as? String
		strInstructionsES = aDecoder.decodeObject(forKey: "strInstructionsES") as? String
		strInstructionsFR = aDecoder.decodeObject(forKey: "strInstructionsFR") as? String
		strInstructionsZHHANS = aDecoder.decodeObject(forKey: "strInstructionsZH-HANS") as? String
		strInstructionsZHHANT = aDecoder.decodeObject(forKey: "strInstructionsZH-HANT") as? String
		strMeasure1 = aDecoder.decodeObject(forKey: "strMeasure1") as? String
		strMeasure10 = aDecoder.decodeObject(forKey: "strMeasure10") as? String
		strMeasure11 = aDecoder.decodeObject(forKey: "strMeasure11") as? String
		strMeasure12 = aDecoder.decodeObject(forKey: "strMeasure12") as? String
		strMeasure13 = aDecoder.decodeObject(forKey: "strMeasure13") as? String
		strMeasure14 = aDecoder.decodeObject(forKey: "strMeasure14") as? String
		strMeasure15 = aDecoder.decodeObject(forKey: "strMeasure15") as? String
		strMeasure2 = aDecoder.decodeObject(forKey: "strMeasure2") as? String
		strMeasure3 = aDecoder.decodeObject(forKey: "strMeasure3") as? String
		strMeasure4 = aDecoder.decodeObject(forKey: "strMeasure4") as? String
		strMeasure5 = aDecoder.decodeObject(forKey: "strMeasure5") as? String
		strMeasure6 = aDecoder.decodeObject(forKey: "strMeasure6") as? String
		strMeasure7 = aDecoder.decodeObject(forKey: "strMeasure7") as? String
		strMeasure8 = aDecoder.decodeObject(forKey: "strMeasure8") as? String
		strMeasure9 = aDecoder.decodeObject(forKey: "strMeasure9") as? String
		strTags = aDecoder.decodeObject(forKey: "strTags") as? String
		strVideo = aDecoder.decodeObject(forKey: "strVideo") as? String
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if dateModified != nil{
			aCoder.encode(dateModified, forKey: "dateModified")
		}
		if idDrink != nil{
			aCoder.encode(idDrink, forKey: "idDrink")
		}
		if strAlcoholic != nil{
			aCoder.encode(strAlcoholic, forKey: "strAlcoholic")
		}
		if strCategory != nil{
			aCoder.encode(strCategory, forKey: "strCategory")
		}
		if strCreativeCommonsConfirmed != nil{
			aCoder.encode(strCreativeCommonsConfirmed, forKey: "strCreativeCommonsConfirmed")
		}
		if strDrink != nil{
			aCoder.encode(strDrink, forKey: "strDrink")
		}
		if strDrinkAlternate != nil{
			aCoder.encode(strDrinkAlternate, forKey: "strDrinkAlternate")
		}
		if strDrinkDE != nil{
			aCoder.encode(strDrinkDE, forKey: "strDrinkDE")
		}
		if strDrinkES != nil{
			aCoder.encode(strDrinkES, forKey: "strDrinkES")
		}
		if strDrinkFR != nil{
			aCoder.encode(strDrinkFR, forKey: "strDrinkFR")
		}
		if strDrinkThumb != nil{
			aCoder.encode(strDrinkThumb, forKey: "strDrinkThumb")
		}
		if strDrinkZHHANS != nil{
			aCoder.encode(strDrinkZHHANS, forKey: "strDrinkZH-HANS")
		}
		if strDrinkZHHANT != nil{
			aCoder.encode(strDrinkZHHANT, forKey: "strDrinkZH-HANT")
		}
		if strGlass != nil{
			aCoder.encode(strGlass, forKey: "strGlass")
		}
		if strIBA != nil{
			aCoder.encode(strIBA, forKey: "strIBA")
		}
		if strIngredient1 != nil{
			aCoder.encode(strIngredient1, forKey: "strIngredient1")
		}
		if strIngredient10 != nil{
			aCoder.encode(strIngredient10, forKey: "strIngredient10")
		}
		if strIngredient11 != nil{
			aCoder.encode(strIngredient11, forKey: "strIngredient11")
		}
		if strIngredient12 != nil{
			aCoder.encode(strIngredient12, forKey: "strIngredient12")
		}
		if strIngredient13 != nil{
			aCoder.encode(strIngredient13, forKey: "strIngredient13")
		}
		if strIngredient14 != nil{
			aCoder.encode(strIngredient14, forKey: "strIngredient14")
		}
		if strIngredient15 != nil{
			aCoder.encode(strIngredient15, forKey: "strIngredient15")
		}
		if strIngredient2 != nil{
			aCoder.encode(strIngredient2, forKey: "strIngredient2")
		}
		if strIngredient3 != nil{
			aCoder.encode(strIngredient3, forKey: "strIngredient3")
		}
		if strIngredient4 != nil{
			aCoder.encode(strIngredient4, forKey: "strIngredient4")
		}
		if strIngredient5 != nil{
			aCoder.encode(strIngredient5, forKey: "strIngredient5")
		}
		if strIngredient6 != nil{
			aCoder.encode(strIngredient6, forKey: "strIngredient6")
		}
		if strIngredient7 != nil{
			aCoder.encode(strIngredient7, forKey: "strIngredient7")
		}
		if strIngredient8 != nil{
			aCoder.encode(strIngredient8, forKey: "strIngredient8")
		}
		if strIngredient9 != nil{
			aCoder.encode(strIngredient9, forKey: "strIngredient9")
		}
		if strInstructions != nil{
			aCoder.encode(strInstructions, forKey: "strInstructions")
		}
		if strInstructionsDE != nil{
			aCoder.encode(strInstructionsDE, forKey: "strInstructionsDE")
		}
		if strInstructionsES != nil{
			aCoder.encode(strInstructionsES, forKey: "strInstructionsES")
		}
		if strInstructionsFR != nil{
			aCoder.encode(strInstructionsFR, forKey: "strInstructionsFR")
		}
		if strInstructionsZHHANS != nil{
			aCoder.encode(strInstructionsZHHANS, forKey: "strInstructionsZH-HANS")
		}
		if strInstructionsZHHANT != nil{
			aCoder.encode(strInstructionsZHHANT, forKey: "strInstructionsZH-HANT")
		}
		if strMeasure1 != nil{
			aCoder.encode(strMeasure1, forKey: "strMeasure1")
		}
		if strMeasure10 != nil{
			aCoder.encode(strMeasure10, forKey: "strMeasure10")
		}
		if strMeasure11 != nil{
			aCoder.encode(strMeasure11, forKey: "strMeasure11")
		}
		if strMeasure12 != nil{
			aCoder.encode(strMeasure12, forKey: "strMeasure12")
		}
		if strMeasure13 != nil{
			aCoder.encode(strMeasure13, forKey: "strMeasure13")
		}
		if strMeasure14 != nil{
			aCoder.encode(strMeasure14, forKey: "strMeasure14")
		}
		if strMeasure15 != nil{
			aCoder.encode(strMeasure15, forKey: "strMeasure15")
		}
		if strMeasure2 != nil{
			aCoder.encode(strMeasure2, forKey: "strMeasure2")
		}
		if strMeasure3 != nil{
			aCoder.encode(strMeasure3, forKey: "strMeasure3")
		}
		if strMeasure4 != nil{
			aCoder.encode(strMeasure4, forKey: "strMeasure4")
		}
		if strMeasure5 != nil{
			aCoder.encode(strMeasure5, forKey: "strMeasure5")
		}
		if strMeasure6 != nil{
			aCoder.encode(strMeasure6, forKey: "strMeasure6")
		}
		if strMeasure7 != nil{
			aCoder.encode(strMeasure7, forKey: "strMeasure7")
		}
		if strMeasure8 != nil{
			aCoder.encode(strMeasure8, forKey: "strMeasure8")
		}
		if strMeasure9 != nil{
			aCoder.encode(strMeasure9, forKey: "strMeasure9")
		}
		if strTags != nil{
			aCoder.encode(strTags, forKey: "strTags")
		}
		if strVideo != nil{
			aCoder.encode(strVideo, forKey: "strVideo")
		}

	}

}
