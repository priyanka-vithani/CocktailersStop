//
//  HttpRequestManager.swift
//  Copyright © 2016 PayalUmraliya. All rights reserved.

import UIKit
import Alamofire
import SwiftyJSON

//Encoding Type
let URL_ENCODING = URLEncoding.default
let JSON_ENCODING = JSONEncoding.default

//Web Service Result

public enum RESPONSE_STATUS : NSInteger
{
    case INVALID
    case VALID
    case MESSAGE
}
protocol UploadProgressDelegate
{
    func didReceivedProgress(progress:Float)
}

protocol DownloadProgressDelegate
{
    func didReceivedDownloadProgress(progress:Float,filename:String)
    func didFailedDownload(filename:String)
}

class HttpRequestManager
{
    static let sharedInstance = HttpRequestManager()
    var additionalHeader = ["User-Agent": "iOS"]
    var responseObjectDic = Dictionary<String, AnyObject>()
    var URLString : String!
    var Message : String!
    var resObjects:AnyObject!
    var alamoFireManager = Alamofire.SessionManager.default
    var delegate : UploadProgressDelegate?
    var downloadDelegate : DownloadProgressDelegate?
    // METHODS
    init()
    {
        alamoFireManager.session.configuration.timeoutIntervalForRequest = 120 //seconds
        alamoFireManager.session.configuration.httpAdditionalHeaders = additionalHeader
    }
    
    
    func load(url: URL, to localUrl: URL, completion: @escaping () -> ()) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
        request.httpMethod = "get"
        
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    //print("Success: \(statusCode)")
                }
                
                do {
                    try FileManager.default.copyItem(at: tempLocalUrl, to: localUrl)
                } catch (let writeError) {
                    //print("error writing file \(localUrl) : \(writeError)")
                }
                completion()
            } else {
                //print("Failure: %@", "\(error?.localizedDescription ?? "ERROR")");
            }
        }
        task.resume()
    }
    
    func download(url: URL, completion: @escaping () -> ())
    {
        let destination = DownloadRequest.suggestedDownloadDestination()
        alamoFireManager.download(url, method: .get, to: destination)
            .downloadProgress { progress in
                //print("Download Progress: \(progress.fractionCompleted)")
                self.downloadDelegate?.didReceivedDownloadProgress(progress:  Float(progress.fractionCompleted), filename: url.absoluteString)
            }.responseData { (response) in
                if let error = response.error{
                    self.downloadDelegate?.didFailedDownload(filename: url.absoluteString)
                    //print("Error: \(error.localizedDescription)")
                }
                
                print(response.destinationURL!.lastPathComponent)
                
                completion()
        }
    }
    
    
    //MARK:- Cancel Request
    func cancelAllAlamofireRequests(responseData:@escaping ( _ status: Bool?) -> Void)
    {
        alamoFireManager.session.getTasksWithCompletionHandler
            {
                dataTasks, uploadTasks, downloadTasks in
                dataTasks.forEach { $0.cancel() }
                uploadTasks.forEach { $0.cancel() }
                downloadTasks.forEach { $0.cancel() }
                responseData(true)
        }
    }
    func getRequest(endpointurl:String,service:String,parameters:NSDictionary,keyname:NSString,message:String,showLoader:Bool,
                    responseData:@escaping  (_ error: NSError?,_ responseArray: NSArray?, _ responseDict: NSDictionary?) -> Void)
    {
        if isConnectedToNetwork()
        {
            if(showLoader)
            {
                
            }
            ShowNetworkIndicator(xx: true)
            
            additionalHeader = ["Accept": "application/json", "Content-Type": "application/x-www-form-urlencoded", "Authorization":""]
            
            alamoFireManager.request(endpointurl, method: .get, parameters: parameters as? [String : AnyObject], headers: additionalHeader).responseString(completionHandler: { (responseString) in
                
                //                print(responseString.value ?? "error")
                ShowNetworkIndicator(xx: false)
                if let responseHttpURL = responseString.response
                {
                    if responseHttpURL.statusCode == 200 {
                        if(responseString.value == nil) {
                            hideLoaderHUD()
                            responseData(responseString.error as NSError?,nil,nil)
                        } else {
                          
                           
                            //*****************post
                            
                            let strResponse = "\(responseString.value!)"
                            let arr = strResponse.components(separatedBy: "\n")
                            let dict =  convertStringToDictionary(str:(arr.last  ?? "")!)
                            let str = dict?["drinks"] as? [[String : Any]]
                         //   self.Message = str
                            let responseStatus = 1
                            print(responseStatus)
                            
                            //*********************get
//                            var strResponse = "\(responseString.value!)"
//                            strResponse = strResponse.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
//                            let arr = strResponse.components(separatedBy: "\n")
//
//                            var result : [[String:Any]]?
//                            for jsonString in arr{
//                                if let jsonDataToVerify = jsonString.data(using: String.Encoding.utf8)
//                                {
//                                    do {
//                                        result = try JSONSerialization.jsonObject(with: jsonDataToVerify, options: [])  as? [[String : Any]]
//
//                                    } catch {
//                                        print("Error deserializing JSON: \(error.localizedDescription)")
//                                    }
//                                }
//                            }
//                            self.Message = ""
                            if(keyname != "")
                            {
                                if str != nil{
                                    self.parseDataget(
                                        dicResponse: str ?? [["":""]],
                                        service: service,
                                        parseKey:keyname,
                                        completionData: {(arrData) -> () in
                                            hideLoaderHUD()
                                            responseData(nil,arrData,nil)
                                    })
                                }else{
                                     responseData(nil,nil,nil)
                                }
                                
                            }
                            else
                            {
                                if str != nil{
                                    hideLoaderHUD()
                                    responseData(nil,str! as NSArray,nil)
                                }else{
                                    responseData(nil,nil,nil)
                                }
                               
                            }
                        
                        }
                    } else {
                        responseData(nil,nil,nil)
                    }
                } else {
                    responseData(nil,nil,nil)
                }
            })
        }
    }
    //MARK:- UPLOAD PERCENTAGE LABEL REFERENCE
    func requestWithPostMultipartParam(lbl:UILabel,endpointurl:String, isImage:Bool,parameters:NSDictionary,responseData:@escaping (_ data: AnyObject?, _ error: NSError?, _ message: String?, _ responseDict: AnyObject?) -> Void)
    {
        if isConnectedToNetwork()
        {
            showHUD()
            alamoFireManager.upload(multipartFormData:
                { multipartFormData in
                    for (key, value) in parameters
                    {
                        if value is NSArray
                        {
                            for value1 in value as! NSArray
                            {
                                if value1 is Data
                                {
                                    multipartFormData.append(value1 as! Data, withName: key as! String, fileName: "wakeup.jpg", mimeType: "image/jpeg")
                                }
                                else if value1 is URL
                                {
                                    let url = value1 as! URL
                                    
                                    let fileExt = (url.lastPathComponent.components(separatedBy: ".").last!).lowercased()
                                    var mime = ""
                                    
                                    switch fileExt{
                                    case "xls":
                                        mime = "application/vnd.ms-excel"
                                        break
                                    case "xlsx":
                                        mime = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                                        break
                                    case "doc":
                                        mime = "application/msword"
                                        break
                                    case "mp4":
                                        mime = "video/mp4"
                                        break
                                    case "docx":
                                        mime = "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
                                        break
                                    case "pdf":
                                        mime = "application/pdf"
                                        break
                                    case "rtf":
                                        mime = "application/rtf"
                                        break
                                    case "txt":
                                        mime = "text/plain"
                                        break
                                    default:
                                        break
                                    }
                                    
                                    var fileData:Data? = nil
                                    do{
                                        fileData = try Data.init(contentsOf: url)
                                        multipartFormData.append(fileData!, withName: key as! String, fileName: "wakeupp.\(fileExt)", mimeType: mime)
                                    }catch{
                                        //print("\(url) : \(error.localizedDescription)")
                                    }
                                    
                                    //  removeFileFromLocal(url.lastPathComponent)
                                }
                                else
                                {
                                    multipartFormData.append("\(value1)".data(using: String.Encoding.utf8)!, withName: key as! String)
                                }
                            }
                        }
                        else
                        {
                            if value is Data
                            {
                                multipartFormData.append(value as! Data, withName: key as! String, fileName: "wakeup.jpg", mimeType: "image/jpeg")
                            }
                            else if value is URL
                            {
                                let url = value as! URL
                                
                                let fileExt = (url.lastPathComponent.components(separatedBy: ".").last!).lowercased()
                                var mime = ""
                                
                                switch fileExt{
                                case "xls":
                                    mime = "application/vnd.ms-excel"
                                    break
                                case "xlsx":
                                    mime = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                                    break
                                case "doc":
                                    mime = "application/msword"
                                    break
                                case "docx":
                                    mime = "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
                                    break
                                case "pdf":
                                    mime = "application/pdf"
                                    break
                                case "rtf":
                                    mime = "application/rtf"
                                    break
                                case "txt":
                                    mime = "text/plain"
                                    break
                                default:
                                    break
                                }
                                
                                var fileData:Data? = nil
                                do{
                                    fileData = try Data.init(contentsOf: url)
                                    multipartFormData.append(fileData!, withName: key as! String, fileName: "helpme.\(fileExt)", mimeType: mime)
                                }catch{
                                    //print("\(url) : \(error.localizedDescription)")
                                }
                                
                                removeFileFromLocal(url.lastPathComponent)
                            }
                            else
                            {
                                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as! String)
                            }
                        }
                    }
            }, to: endpointurl,encodingCompletion:
                { encodingResult in
                    switch encodingResult
                    {
                    case .success(let upload, _, _):
                        upload.uploadProgress(closure: { (progress) in
                            self.delegate?.didReceivedProgress(progress: Float(progress.fractionCompleted))
                            
                        })
                        upload.responseString(completionHandler:{(responseString) in
                            print(responseString.value ?? "error")
                            ShowNetworkIndicator(xx: false)
                            if(responseString.value == nil)
                            {
                                responseData(nil, responseString.error as NSError?, nil, responseString.error as AnyObject?)
                                hideHUD()
                            }
                            else
                            {
                                let strResponse = "\(responseString.value!)"
                                let arr = strResponse.components(separatedBy: "\n")
                                let dict =  convertStringToDictionary(str:(arr.last  ?? "")!)
                                let str = dict?[kMessage] as? String ?? ServerResponseError
                                
                                self.Message = str
                                let responseStatus = dict?[kStatus] as? Int ?? 0
                                print(responseStatus)
                                switch (responseStatus)
                                {
                                case RESPONSE_STATUS.VALID.rawValue:
                                    self.resObjects = dict as AnyObject
                                    break
                                case RESPONSE_STATUS.INVALID.rawValue:
                                    self.resObjects = nil
                                    break
                                    
                                default :
                                    break
                                }
                                hideHUD()
                                responseData(self.resObjects, nil, self.Message, responseString.value as AnyObject?)
                            }
                        })
                        break
                    case .failure(let encodingError):
                        hideHUD()
                        //print("ENCODING ERROR: ",encodingError)
                        responseData(nil, nil, nil, nil)
                    }
            })
        }
    }
    //MARK:- POST
    func requestWithPostMultipartParam(endpointurl:String, isImage:Bool,parameters:NSDictionary,responseData:@escaping (_ data: AnyObject?, _ error: NSError?, _ message: String?, _ responseDict: AnyObject?) -> Void)
    {
        if isConnectedToNetwork()
        {
           
            showHUD()
            alamoFireManager.upload(multipartFormData:
                { multipartFormData in
                    for (key, value) in parameters
                    {
                        if value is NSArray
                        {
                            for value1 in value as! NSArray
                            {
                                if value1 is Data
                                {
                                    multipartFormData.append(value1 as! Data, withName: key as! String, fileName: "wakeup.jpg", mimeType: "image/jpeg")
                                }
                                else if value1 is URL
                                {
                                    let url = value1 as! URL
                                    
                                    let fileExt = (url.lastPathComponent.components(separatedBy: ".").last!).lowercased()
                                    var mime = ""
                                    
                                    switch fileExt{
                                    case "xls":
                                        mime = "application/vnd.ms-excel"
                                        break
                                    case "xlsx":
                                        mime = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                                        break
                                    case "doc":
                                        mime = "application/msword"
                                        break
                                    case "mp4":
                                        mime = "video/mp4"
                                        break
                                    case "docx":
                                        mime = "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
                                        break
                                    case "pdf":
                                        mime = "application/pdf"
                                        break
                                    case "rtf":
                                        mime = "application/rtf"
                                        break
                                    case "txt":
                                        mime = "text/plain"
                                        break
                                    case "png", "jpg", "jpeg":
                                        mime = "image/png"
                                    case "m4a":
                                        mime = "audio/m4a"
                                    case "mp3":
                                        mime = "audio/mp3"
                                    default:
                                        break
                                    }
                                    
                                    var fileData:Data? = nil
                                    do{
                                        fileData = try Data.init(contentsOf: url)
                                        multipartFormData.append(fileData!, withName: key as! String, fileName: "wakeupp.\(fileExt)", mimeType: mime)
                                    }catch{
                                        //print("\(url) : \(error.localizedDescription)")
                                    }
                                    
                                    //  removeFileFromLocal(url.lastPathComponent)
                                }
                                else
                                {
                                    multipartFormData.append("\(value1)".data(using: String.Encoding.utf8)!, withName: key as! String)
                                }
                            }
                        }
                        else
                        {
                            if value is Data
                            {
                                multipartFormData.append(value as! Data, withName: key as! String, fileName: "wakeup.jpg", mimeType: "image/jpeg")
                            }
                            else if value is URL
                            {
                                let url = value as! URL
                                
                                let fileExt = (url.lastPathComponent.components(separatedBy: ".").last!).lowercased()
                                var mime = ""
                                
                                switch fileExt{
                                case "xls":
                                    mime = "application/vnd.ms-excel"
                                    break
                                case "xlsx":
                                    mime = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                                    break
                                case "doc":
                                    mime = "application/msword"
                                    break
                                case "docx":
                                    mime = "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
                                    break
                                case "pdf":
                                    mime = "application/pdf"
                                    break
                                case "rtf":
                                    mime = "application/rtf"
                                    break
                                case "txt":
                                    mime = "text/plain"
                                    break
                                default:
                                    break
                                }
                                
                                var fileData:Data? = nil
                                do{
                                    fileData = try Data.init(contentsOf: url)
                                    multipartFormData.append(fileData!, withName: key as! String, fileName: "helpme.\(fileExt)", mimeType: mime)
                                }catch{
                                    //print("\(url) : \(error.localizedDescription)")
                                }
                                
                                removeFileFromLocal(url.lastPathComponent)
                            }
                            else
                            {
                                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as! String)
                            }
                            
                        }
                    }
            }, to: endpointurl,encodingCompletion:
                { encodingResult in
                    switch encodingResult
                    {
                    case .success(let upload, _, _):
                        upload.uploadProgress(closure: { (progress) in
                            self.delegate?.didReceivedProgress(progress: Float(progress.fractionCompleted))
                            //print("Upload Progress : \(Float(progress.fractionCompleted))")
                        })
                        upload.responseString(completionHandler:{(responseString) in
                            print(responseString.value ?? "error")
                            ShowNetworkIndicator(xx: false)
                            if(responseString.value == nil)
                            {
                                responseData(nil, responseString.error as NSError?, nil, responseString.error as AnyObject?)
                                hideHUD()
                            }
                            else
                            {
                                let strResponse = "\(responseString.value!)"
                                let arr = strResponse.components(separatedBy: "\n")
                                let dict =  convertStringToDictionary(str:(arr.last  ?? "")!)
                                let str = dict?[kMessage] as? String ?? ServerResponseError
                                
                                self.Message = str
                                let responseStatus = dict?[kStatus] as? Int ?? 0
                                print(responseStatus)
                                switch (responseStatus)
                                {
                                case RESPONSE_STATUS.VALID.rawValue:
                                    self.resObjects = dict as AnyObject
                                    break
                                case RESPONSE_STATUS.INVALID.rawValue:
                                    self.resObjects = nil
                                    break
                                    
                                default :
                                    break
                                }
                                hideHUD()
                                responseData(self.resObjects, nil, self.Message, responseString.value as AnyObject?)
                            }
                        })
                        break
                    case .failure(let encodingError):
                        hideHUD()
                        responseData(nil, nil, "\(encodingError)", nil)
                    }
            })
        }
    }
    //requestWithPostJsonParam
    func requestWithPostJsonParam( endpointurl:String,
                                   service:String,
                                   parameters:NSDictionary,
                                   keyname:NSString,
                                   message:String,
                                   showLoader:Bool,
                                   responseData:@escaping  (_ error: NSError?,_ responseStatus:String,_ responseMessage:String,_ responseArray: NSArray?, _ responseDict: NSDictionary?) -> Void)
    {
        if isConnectedToNetwork()
        {
            if(showLoader)
            {
//                hideHUD()
//                showHUD()
            }
           
            ShowNetworkIndicator(xx: true)
            alamoFireManager.request(endpointurl, method: .get, parameters: parameters as? Parameters, encoding: JSONEncoding.default, headers: additionalHeader)
                .responseString(completionHandler: { (responseString) in
                    print(responseString.value ?? "error")
                    ShowNetworkIndicator(xx: false)
                    if(responseString.value == nil)
                    {
                        hideLoaderHUD()
                        responseData(responseString.error as NSError?,"0","\(responseString.error?.localizedDescription ?? ServerResponseError)",nil,nil)
                    }
                    else
                    {
                        let strResponse = "\(responseString.value!)"
                        let arr = strResponse.components(separatedBy: "\n")
                        let dict =  convertStringToDictionary(str:(arr.last  ?? "")!)
                        let str = dict?[kMessage] as? String ?? ServerResponseError
                        self.Message = str
                        let responseStatus = dict?[kStatus] as? Int ?? 0
                        print(responseStatus)
                        switch (responseStatus)
                        {
                        case RESPONSE_STATUS.VALID.rawValue:
                            self.resObjects = dict as AnyObject
                            
                            if(keyname != "")
                            {
                                self.parseData(
                                    dicResponse: self.resObjects as! NSDictionary,
                                    service: service,
                                    parseKey:keyname,
                                    completionData: {(arrData) -> () in
                                        hideLoaderHUD()
                                        responseData(nil,"\(responseStatus)","\(self.Message!)",arrData,self.resObjects as? NSDictionary)
                                })
                            }
                            else
                            {
                                hideLoaderHUD()
                                responseData(nil,"\(responseStatus)","\(self.Message!)",[],self.resObjects as? NSDictionary)
                            }
                            break
                        case RESPONSE_STATUS.INVALID.rawValue:
                            self.resObjects = nil
                            if keyname == ""
                            {
                                let arr = NSMutableArray()
                                arr.add("\(responseStatus)")
                                arr.add(self.Message ?? "")
                                responseData(nil,"\(responseStatus)","\(self.Message!)",arr,dict as NSDictionary?)
                            }
                            else
                            {
                                if(dict != nil)
                                {
                                    responseData(nil,"\(responseStatus)","\(self.Message!)",[], dict as NSDictionary?)
                                }
                                else
                                {
                                    let error = NSError.init(domain: "", code: 8888, userInfo: ["LocalizedDescription" : "Response data invalid"])
                                    responseData(error,"\(responseStatus)","\(self.Message!)",[], nil)
                                }
                            }
                            break
                        default :
                            break
                        }
                    }
                })
        }
    }
    
    func parseData(
        dicResponse:NSDictionary,
        service:String,
        parseKey:NSString,
        completionData:@escaping(_ arrData:NSMutableArray)->())
    {
        
        let arrResponseData = NSMutableArray()
        for (key, _) in dicResponse
        {
            if(key as! String == parseKey as String)
            {
                return
            }
        }
    }
    func parseDataget(
        dicResponse:[[String:Any]],
        service:String,
        parseKey:NSString,
        completionData:@escaping(_ arrData:NSMutableArray)->())
    {
        
        let arrResponseData = NSMutableArray()
        if service == "Drinks"
        {
            for obj in dicResponse
            {
                let j = JSON(obj)
                let objData:Drinks = Drinks.init(fromJson: j)
                arrResponseData.add(objData)
            }
           completionData(arrResponseData)
        }
      
    }
}
