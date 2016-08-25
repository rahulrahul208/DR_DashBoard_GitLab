//
//  DrDB_ElementsGroupModel.swift
//  NewDrDashBoard
//
//  Created by MACBookPro on 8/17/16.
//  Copyright © 2016 cognizant. All rights reserved.
//

import UIKit

class DrDB_ElementsGroupModel: NSObject {
    
    var vitalElements:[DrDB_ParameterValueModel]?
    var investigationElements:[DrDB_ParameterValueModel]?

    
    init(dataDict:Dictionary<String ,AnyObject>) {
        
        
        self.vitalElements = Array()
        self.investigationElements = Array()

        if let itemDataArray:[Dictionary<String ,AnyObject>] = dataDict["elements_detail"] as? [Dictionary<String ,AnyObject>]{
            
            for (_ ,elementsDataDict) in itemDataArray.enumerate()
            {
                if let vitalElementArray:[Dictionary<String ,AnyObject>]  = elementsDataDict["vital_data"] as? [Dictionary<String ,AnyObject>]{
                    
                    for (_ ,elementsDataDict) in vitalElementArray.enumerate()
                    {
                        let elementsGroupModel = DrDB_ParameterValueModel(dataDict:elementsDataDict)
                        
                        self.vitalElements?.append(elementsGroupModel)
                    }

                }
                else if  let investigationElementArray:[Dictionary<String ,AnyObject>]  = elementsDataDict["investigation_data"] as? [Dictionary<String ,AnyObject>]{
                    
                    for (_ ,elementsDataDict) in investigationElementArray.enumerate()
                    {
                        let elementsGroupModel = DrDB_ParameterValueModel(dataDict:elementsDataDict)
                        
                        self.investigationElements?.append(elementsGroupModel)
                    }
                    
                }
            
            }
            
            
        }

        
//        if let itemDataArray:[Dictionary<String ,AnyObject>] = dataDict["vital_data"] as? [Dictionary<String ,AnyObject>]
//        {
//            for (_ ,elementsDataDict) in itemDataArray.enumerate()
//            {
//                let elementsGroupModel = DrDB_ParameterValueModel(dataDict:elementsDataDict)
//                self.vitalElements?.append(elementsGroupModel)
//            }
//            
//        }
//        else if let itemDataArray:[Dictionary<String ,AnyObject>] = dataDict["investigation_data"] as? [Dictionary<String ,AnyObject>]
//        {
//            for (_ ,elementsDataDict) in itemDataArray.enumerate()
//            {
//                let elementsGroupModel = DrDB_ParameterValueModel(dataDict:elementsDataDict)
//                self.investigationElements?.append(elementsGroupModel)
//            }
//            
//        }
        
    }

}
