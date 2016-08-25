//
//  WebAPIManager.swift
//  DrDashBoard
//
//  Created by CTSiMac007 on 23/06/16.
//  Copyright © 2016 CTSiMac007. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WebAPIManager: NSObject {
    
    var requestUrl = ""
    var jsonArray:NSMutableArray?
    var newArray: Array<String> = []

    
    //MARK: Self Singleton variable
    /*
     @ This is class variable which creates self Singleton object
     */
    class var sharedInstance: WebAPIManager {
        struct Singleton {
            static let instance = WebAPIManager()
        }
        return Singleton.instance
     }
    
    
    func getApiCall(apiPath:String ,params:String ,result:AnyObject->()){
        

        if (apiPath.characters.count) > 0
        {
            
            requestUrl  = GlobalConstants.BaseURLLocal.baseURL + apiPath + params.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
            
        }
        print(requestUrl)
        
        
        Alamofire.request(.GET, requestUrl) .responseJSON { response in
            print("Request:\(response.request)")  // original URL request
            print("Response:\(response.response)") // URL response
            print("Data:\(response.data)")     // server data
            print("Result:\(response.result)")   // result of response serialization
            print("JSON:\(response.result.value)")   // result of response serialization


            if let resultObj = response.result.value {
                
                self.parseData(apiPath, dataDict:resultObj as! Dictionary<String, AnyObject>)

            }
        }
    }
    
    
    func postApiCall(apiPath:String ,params:NSDictionary ,result:AnyObject->()){
        
            requestUrl  = (GlobalConstants.BaseURLLocal.baseURL + apiPath)
        
//        print(requestUrl)
      
        Alamofire.request(.POST, requestUrl, parameters: params as? [String : AnyObject],encoding: .JSON).responseJSON { response in
            print("Request:\(response.request)")  // original URL request
            print("Response:\(response.response)") // URL response
            print("Data:\(response.data)")     // server data
            print("Result:\(response.result)")   // result of response serialization
            print("JSON:\(response.result.value)")   // result of response serialization
            
            
            if let resultObj = response.result.value {
                self.parseData(apiPath, dataDict:resultObj as! Dictionary<String, AnyObject>)
                result("Success")
            }
            else{
              result("fail")
            }
        }
    }
    
    //Main Function of parsing
    func parseData(urlName:String ,dataDict:Dictionary<String, AnyObject>)
    {
        switch(urlName)
        {
        case GlobalConstants.validateDoctorEmail.validateDoctorEmail:
          self.parseDoctorInfoData(dataDict)

        case GlobalConstants.GetPatientData.getAllPatient:
            self.parseAllActivePatientsData(dataDict)
//        case GlobalConstants.GetDoctorDetail.getDoctorDetail:
//            self.parseDoctorDetailData(dataDict)

            
        default:
            print(urlName)
        }
    }

    // Mark: Parse Methods
  
    //Parse Email Result

    func parseDoctorInfoData(dataDict:Dictionary<String, AnyObject>)
    {
      
      let detailDict:Dictionary<String,AnyObject> = dataDict["doctor_info"] as! Dictionary<String,AnyObject>
      
      let detailDictObj = DrDB_DoctorsInfoModel(dataDict:detailDict)
      
      DataManager.sharedInstance.doctorInfoData = detailDictObj

    }


    //Active Patients Parse Result
    func parseAllActivePatientsData(dataDict:Dictionary<String, AnyObject>)
    {
        let resultDict:[Dictionary<String ,AnyObject>] = dataDict["active_patients"] as! [Dictionary<String ,AnyObject>]

        
        for (_ ,dict) in resultDict.enumerate()
        {
            let dictObj = DrDB_PatientInfoModel(dataDict: dict)
            DataManager.sharedInstance.activePatientList.append(dictObj)
          
          if(dictObj.personnelID == DataManager.sharedInstance.doctorInfoData?.personnelID){
            DataManager.sharedInstance.myActivePatientList.append(dictObj)
          }
        }
        
    }
    
    // Mark: Parse Methods
    //Doctor Info Parse Result
//    func parseDoctorDetailData(dataDict:Dictionary<String, AnyObject>)
//    {
//        let resultDict:[Dictionary<String ,AnyObject>] = dataDict["doctor_info"] as! [Dictionary<String ,AnyObject>]
//        
//        
//        for (_ ,dict) in resultDict.enumerate()
//        {
//            let dictObj = DoctorDetailModel(dataDict:dict)
//            DataManager.sharedInstance.doctorDetail  = dictObj
//        }
//        
//    }
  
}
