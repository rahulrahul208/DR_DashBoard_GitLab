//
//  DrDB_ElementsModel.swift
//  NewDrDashBoard
//
//  Created by MACBookPro on 8/17/16.
//  Copyright © 2016 cognizant. All rights reserved.
//

import UIKit

class DrDB_ElementsModel: NSObject {

    var elementValue:[DrDB_ParameterValueModel]?


    init(dataDict:Dictionary<String ,AnyObject>) {
        
        self.elementValue = Array()

//            for (_ ,elementsDataDict) in dataDict.enumerate()
//            {
//                let elementsGroupModel = DrDB_ParameterValueModel(dataDict:elementsDataDict)
//                self.elementValue?.append(elementsGroupModel)
//            }

    }

}
