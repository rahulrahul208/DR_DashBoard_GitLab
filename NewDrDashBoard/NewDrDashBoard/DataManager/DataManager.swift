//
//  DataManager.swift
//  DrDashBoard
//
//  Created by CTSiMac007 on 24/06/16.
//  Copyright © 2016 CTSiMac007. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    
    // Active Patient Data
    var activePatientList:[DrDB_PatientInfoModel] = Array()
    var myActivePatientList:[DrDB_PatientInfoModel] = Array()

//    var activePatientDetail:[ActivePatientDetailModel] = Array()
//    var PatientVitalParameters:[PatientParametersModel] = Array()
//    var PatientInvestigationParameters:[PatientParametersModel] = Array()
//    var PatientInsAndOutParameters:[PatientParametersModel] = Array()
//    var PatientMedicationParameters:[PatientParametersModel] = Array()
//    var PatientEquipmentParameters:[PatientParametersModel] = Array()
//    var PatientOrdersParameters:[PatientParametersModel] = Array()
//    var PatientSignificantParameters:[PatientParametersModel] = Array()
//    var doctorDetail:DoctorDetailModel?

  var doctorInfoData:DrDB_DoctorsInfoModel?

  var validateEmailResult:String?
  
    class var sharedInstance: DataManager {
        struct Singleton {
            
            static let instance = DataManager()
            
        }
        
        return Singleton.instance
    }    
}
