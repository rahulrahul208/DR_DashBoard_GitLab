//
//  DrDB_ParameterValueModel.swift
//  NewDrDashBoard
//
//  Created by MACBookPro on 8/18/16.
//  Copyright © 2016 cognizant. All rights reserved.
//

import UIKit

class DrDB_ParameterValueModel: NSObject {

    
    var elementName:String?
    var elementValue:String?
    var dateTime:String?
    var isAlert:String?
    var elementRange:String?
    var elementUnit:String?
    var ipNumber:String?
    

    init(dataDict:Dictionary<String ,AnyObject>) {
        elementName = dataDict["name"] as? String
        dateTime = dataDict["date_time"] as? String
        elementValue = dataDict["value"] as? String
        isAlert = dataDict["alert"] as? String
        elementRange = dataDict["range_value"] as? String
        elementUnit = dataDict["unit"] as? String
        ipNumber = dataDict["ip_number"] as? String
    }

}
