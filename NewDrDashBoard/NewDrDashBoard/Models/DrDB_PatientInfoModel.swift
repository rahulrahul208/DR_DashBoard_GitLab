//
//  DrDB_PatientInfoModel.swift
//  NewDrDashBoard
//
//  Created by MACBookPro on 8/17/16.
//  Copyright © 2016 cognizant. All rights reserved.
//

import UIKit

class DrDB_PatientInfoModel: NSObject {
    
    
    var patientName:String?
    var gender:String?
    var age:NSNumber?
    var pod:NSNumber?
    var diagnosis:String?
    var operationPerformed:String?
    var ipNumber:String?
    var totalAlert:NSNumber?
    var vitalAlert:NSNumber?
    var investigationAlert:NSNumber?
    var insOutAlert:NSNumber?
    var doctorName:String?
    var personnelID:NSNumber?


    
    var elementsGroup:[DrDB_ElementsGroupModel]?
    var elementsAlert:[DrDB_ParameterValueModel]?

  
    init(dataDict:Dictionary<String ,AnyObject>) {
        
        
        patientName = dataDict["name"] as? String
        gender = dataDict["gender"] as? String
        age = dataDict["age"] as? NSNumber
        pod = dataDict["pod"] as? NSNumber
        diagnosis = dataDict["diagnosis"] as? String
        operationPerformed = dataDict["operation_performed"] as? String
        ipNumber = dataDict["ip_number"] as? String
        totalAlert = dataDict["total_alert"] as? NSNumber
        vitalAlert = dataDict["vital_alert"] as? NSNumber
        investigationAlert = dataDict["investigation_alert"] as? NSNumber
        insOutAlert = dataDict["ins_out_alert"] as? NSNumber
        doctorName = dataDict["doctor_name"] as? String
        personnelID = dataDict["personnel_id"] as? NSNumber

        
        self.elementsGroup = Array()
        self.elementsAlert = Array()

      
        let groupModel = DrDB_ElementsGroupModel(dataDict:dataDict)
        self.elementsGroup?.append(groupModel)
      
      
        if let itemDataArray:[Dictionary<String ,AnyObject>] = dataDict["alerts_elements"] as? [Dictionary<String ,AnyObject>]{
          
          for (_ ,elementsDataDict) in itemDataArray.enumerate()
          {
                let elementsGroupModel = DrDB_ParameterValueModel(dataDict:elementsDataDict)
                
                self.elementsAlert?.append(elementsGroupModel)
          }
              
        }
      }
}
