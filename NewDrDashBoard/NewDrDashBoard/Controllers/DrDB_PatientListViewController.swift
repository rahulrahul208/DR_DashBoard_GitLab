//
//  DrDB_PatientListViewController.swift
//  NewDrDashBoard
//
//  Created by MACBookPro on 8/12/16.
//  Copyright © 2016 cognizant. All rights reserved.
//

import UIKit

class DrDB_PatientListViewController: UIViewController,UIPopoverPresentationControllerDelegate {

  @IBOutlet weak var tableViewPatientList: UITableView!
  @IBOutlet weak var patientInfoCell: DrDB_PatientInfoCell!

  
    enum SegmentControlSelectionValue{
        case AllPatient
        case MyPatient
    }

    var patientInfoDict = [String:AnyObject]()
    var allPatientInfoDataSource = [[String:AnyObject]]()
    var myPatientInfoDataSource = [[String:AnyObject]]()
    var patientList = [DrDB_PatientInfoModel]()
  
    var segmentControlSelectionValue = SegmentControlSelectionValue.AllPatient
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
//        self.navigationController!.navigationBarHidden = true
      

        self.setLeftBarItem()
      
        self.getData()
        
    }
  
  
  //MARK: Custome Method Started

    func setLeftBarItem(){
      
      
      let docNameLabel = UILabel(frame: CGRect(x: -220, y: 5, width: 200, height: 21))
      
      if let doctorDetail = DataManager.sharedInstance.doctorInfoData{
        docNameLabel.text = doctorDetail.name
      }
      

      let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
      imageView.contentMode = .ScaleAspectFit
      let logo = UIImage(named: "doctor_logo")
      imageView.image = logo
      self.navigationItem.titleView = imageView
      
    }
    
    func getData(){
        
      
      self.addLoadingIndicator()
      Utility.sharedInstance.activityIndicator.startAnimating()


        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Hi John", style: .Plain, target: nil, action: nil)

//        let params: [String : AnyObject]=["eMail":"\(emailID)", "code":"\(passcode)"]
        
        let params: [String : AnyObject]=["eMail":"shafi.m@cognizant.com", "code":"4848"]

        
        WebAPIManager.sharedInstance.postApiCall(GlobalConstants.GetPatientData.getAllPatient,
                                                 params:params,
                                                 result:{(resultObject) -> Void in
                                                    print("Patient's Data Received")
                                                    
                                                    print(resultObject)
                                                    
                                                    dispatch_async(dispatch_get_main_queue(), {
                                                      
                                                      self.patientList = DataManager.sharedInstance.activePatientList
                                                        self.updateUI()
                                                        Utility.sharedInstance.activityIndicator.stopAnimating()

                                                      
                                                    })
                                                    
                                                    
        })
    }
    
    func updateUI()
    {
      if self.patientList.count > 0 {
        self.tableViewPatientList.delegate = self
        self.tableViewPatientList.dataSource = self
        self.tableViewPatientList.reloadData()
        
      }
    }
  
    func configureScrollView(cell : UITableViewCell){
      
      
    }
    
    func addLoadingIndicator () {
      self.view.addSubview(Utility.sharedInstance.activityIndicator)
      self.view.bringSubviewToFront(Utility.sharedInstance.activityIndicator)
      Utility.sharedInstance.activityIndicator.center = self.view.center
    }

  
  //MARK: Custome Method Ended

  
    //MARK: IBAction started
    @IBAction func warningAction(sender: AnyObject) {
      
      let buttonPosition = sender.convertPoint(CGPointZero, toView: self.tableViewPatientList)
      let indexPath = self.tableViewPatientList.indexPathForRowAtPoint(buttonPosition)

      
      let storyboard : UIStoryboard = self.storyboard!
      
      let alertViewCtrl = storyboard.instantiateViewControllerWithIdentifier("WarningsViewControllerID") as! DrDB_WarningsViewController
      
      alertViewCtrl.modalPresentationStyle = .Popover
      alertViewCtrl.preferredContentSize = CGSizeMake(300, 250)
      // quickBookViewCtrl.delegate = self
      
      let popoverMenuViewController = alertViewCtrl.popoverPresentationController
      popoverMenuViewController?.permittedArrowDirections =  UIPopoverArrowDirection(rawValue: 0)
      popoverMenuViewController?.delegate = self
      popoverMenuViewController?.sourceView = self.view
      popoverMenuViewController?.sourceRect = CGRect(
        x: CGRectGetMidX(self.view.frame),
        y: CGRectGetMidY(self.view.frame),
        width: 1,
        height: 1)
      presentViewController(
        alertViewCtrl,
        animated: true,
        completion: nil)

    }
  
  
    @IBAction func segmentControlValueChanged(sender: AnyObject) {
      
      let segmentcontrol = sender as? UISegmentedControl
      if segmentcontrol?.selectedSegmentIndex == 0{
        segmentControlSelectionValue = SegmentControlSelectionValue.AllPatient
        self.patientList = DataManager.sharedInstance.activePatientList
      }else{
        segmentControlSelectionValue = SegmentControlSelectionValue.MyPatient
        self.patientList = DataManager.sharedInstance.myActivePatientList
      }
      
      self.tableViewPatientList.reloadData()
    }
  
  
    //MARK: IBAction Ended




    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension DrDB_PatientListViewController : UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.patientList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
      let patientInfoCell  = tableView.dequeueReusableCellWithIdentifier("PatientInfoCellIdentifier") as! DrDB_PatientInfoCell
        
        let patientDict = self.patientList[indexPath.row]
      
        patientInfoCell.lblName.text = "\(patientDict.patientName!) (\(patientDict.gender!)/\(patientDict.age!))"
        patientInfoCell.lblOperationPerformed.text = patientDict.operationPerformed
        patientInfoCell.lblDiagnosis.text = patientDict.diagnosis
        patientInfoCell.lblPod.text = "POD : \(patientDict.pod!)"
      
        if(patientDict.totalAlert?.integerValue > 0 ){
          if let elementAlertArr  = patientDict.elementsAlert{
            
            patientInfoCell.elementAlertArr = elementAlertArr

          }
          patientInfoCell.configureScrollView()
          
        }
      
        return patientInfoCell
    }
    
    
    
}

extension DrDB_PatientListViewController : UITableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let patientDetailVC = storyboard?.instantiateViewControllerWithIdentifier("PatientDetailVCIdentifier")
        navigationController?.pushViewController(patientDetailVC!, animated: true)
    }
}

