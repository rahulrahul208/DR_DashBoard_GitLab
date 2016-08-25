//
//  DrDB_DoctorsInfoModel.swift
//  NewDrDashBoard
//
//  Created by MSP-User3 on 11/08/16.
//  Copyright © 2016 cognizant. All rights reserved.
//

import UIKit

class DrDB_DoctorsInfoModel: NSObject {

  
  var personnelID:NSNumber?
  var doctorID:String?
  var name:String?
  var personnelType:NSNumber?
  var phoneNumber:String?
  var emailID:String?
  var passcode:NSNumber?
  var deviceID:NSNumber?
  
  init(dataDict:Dictionary<String ,AnyObject>) {
    personnelID = dataDict["personnel_id"] as? NSNumber
    doctorID = dataDict["doctor_id"] as? String
    name = dataDict["name"] as? String
    personnelType = dataDict["personnel_type"] as? NSNumber
    phoneNumber = dataDict["phone_number"] as? String
    emailID = dataDict["email_id"] as? String
    passcode = dataDict["password"] as? NSNumber
    deviceID = dataDict["device_id"] as? NSNumber
  }

}

