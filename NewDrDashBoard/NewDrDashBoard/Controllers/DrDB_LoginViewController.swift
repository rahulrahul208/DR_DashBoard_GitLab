//
//  DrDB_LoginViewController.swift
//  NewDrDashBoard
//
//  Created by MSP-User3 on 08/08/16.
//  Copyright © 2016 cognizant. All rights reserved.
//

import UIKit


class DrDB_LoginViewController: UIViewController {
  
  @IBOutlet var txtFldEmailID:UITextField?
  @IBOutlet var lblWarningMsg:UILabel?
  @IBOutlet var btnSubmit:UIButton?


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      self.navigationController!.navigationBarHidden = true
      
    }

    override func viewWillAppear(animated: Bool) {
      super.viewWillAppear(animated)
      
      lblWarningMsg?.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  

    
    // MARK: - Button Actions
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
        
        self.validateEmailAddress()
        
    }

    // MARK: - Custom Methods
    
    func validateEmailAddress(){
        
        Utility.sharedInstance.activityIndicator.startAnimating()
        
        guard let emailID = txtFldEmailID!.text where emailID != "" else{
            self.view.makeToast(message:"Please Enter Email ID", duration:1.0, position:HRToastPositionDefault)
            return
        }
        
        guard let validEmail = txtFldEmailID!.text where self.isValidEmail(validEmail) == true else{
            self.view.makeToast(message:"Please Enter Valid Email ID", duration:1.0, position:HRToastPositionDefault)
            return
        }
        
        //Params Always Need Dictionary
        
        let deviceId = Utility.getUUIDFromVendorIdentifier
        
        let params: [String : AnyObject]=["eMail":"\(emailID)", "deviceID":"\(deviceId)"]
        
        
        WebAPIManager.sharedInstance.postApiCall(GlobalConstants.validateDoctorEmail.validateDoctorEmail,
                                                 params:params,
                                                 result:{(resultObject) -> Void in
                                                    
                                                    
                                                    if resultObject as! String == "Success"
                                                    {
                                                        print("Doctors's Email Validated")
                                                        
                                                        dispatch_async(dispatch_get_main_queue(), {
                                                            
                                                            Utility.sharedInstance.activityIndicator.stopAnimating()
                                                            
                                                            self.updateUI()
                                                            
                                                        })
                                                    }else{
                                                        print("Email ID is not Valid")
                                                        
                                                    }
        })
        
    }
    
    
    func updateUI()
    {
        
        if DataManager.sharedInstance.doctorInfoData != nil{
            
            let message = "Your passcode has been sent to \(DataManager.sharedInstance.doctorInfoData?.emailID)"
            let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default)
            { action -> Void in
                // Put your code here
                
                let passcodeViewControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("PasscodeViewControllerID") as? DrDB_PasscodeViewController
                self.navigationController?.pushViewController(passcodeViewControllerObj!, animated: true)
                
                
                })
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }
        
    }

    //MARK: - Email Validation
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
