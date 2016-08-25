//
//  GlobalConstants.swift
//  DrDashBoard
//
//  Created by CTSiMac007 on 23/06/16.
//  Copyright © 2016 CTSiMac007. All rights reserved.
//

import Foundation


struct GlobalConstants {
    
    //1.Base URL
    struct BaseURLLocal {
//        static let baseURL:String = "http://10.226.62.228:9090/PatientAnalysis_Reports/rest/drdashboardapp/"
//      static let baseURL:String = "http://10.226.62.228:9090/drDashBoard_Latest/rest/drdashboardapp/"
      static let baseURL:String = "http://192.168.2.14:8080/DrDashboard/rest/drdashboardapp/"
      
    }

    //Get  Patient's Data

    struct GetPatientData {
        static let getAllPatient:String = "getAllPatient"
        static let getDoctorsPatient:String = "getDoctorPatient"
        
        static let getPatientDetail:String = "getPatientDetail"
        
        static let getVital:String = "getVital"
        static let getInvestigation:String = "getInvestigation"
        static let getInputOutput:String = "getInputOutput"
        static let getMedication:String = "getMedication"
        static let getEquipment:String = "getEquipment"
        static let getOrders:String = "getOrders"
        static let getSignificantEvents:String = "getSignificantEvents"
        static let getPersonelData:String = "getPersonelData"


    }

    //Get  Doctor's Details

    struct GetDoctorDetail {
        static let getDoctorDetail:String = "getDoctorDetail"
        static let getDoctorType:String = "getDoctorType"
        static let getDoctorName:String = "getDoctorName"
    }
  
    //Validate Doctor Email ID
    struct validateDoctorEmail {
      static let validateDoctorEmail:String = "validateEmailId"
    }

  
//    struct Path {
//        static let Documents = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
//        static let Tmp = NSTemporaryDirectory()
//    }
}