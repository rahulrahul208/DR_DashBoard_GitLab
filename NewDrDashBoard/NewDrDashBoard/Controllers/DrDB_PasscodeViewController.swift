//
//  DrDB_PasscodeViewController.swift
//  NewDrDashBoard
//
//  Created by MSP-User3 on 08/08/16.
//  Copyright © 2016 cognizant. All rights reserved.
//

import UIKit

class DrDB_PasscodeViewController: UIViewController {

    @IBOutlet var imgDoctor:UIImageView?
    @IBOutlet var lblDoctorName:UILabel?
    @IBOutlet var tfdPasscode1:UITextField?
    @IBOutlet var tfdPasscode2:UITextField?
    @IBOutlet var tfdPasscode3:UITextField?
    @IBOutlet var tfdPasscode4:UITextField?
    @IBOutlet var btnNext:UIButton?
    @IBOutlet var btnForgotPasscode:UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController!.navigationBarHidden = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func actionPasscodeOK(sender: AnyObject)
    {
        Utility.sharedInstance.activityIndicator.startAnimating()
        
        if (tfdPasscode1!.text != "" && tfdPasscode2!.text != "" && tfdPasscode3!.text != "" && tfdPasscode4!.text != "")
        {
            
            let passCodeValue = "\(tfdPasscode1!.text)\(tfdPasscode2!.text)\(tfdPasscode3!.text)\(tfdPasscode4!.text)"
            
            let doctorPersonnelID:NSNumber!
            
            if let doctorInfo = DataManager.sharedInstance.doctorInfoData
            {
                if passCodeValue == doctorInfo.passcode
                {
                    doctorPersonnelID = doctorInfo.personnelID
                    
                    
                    //Params Always Need Dictionary
                    let params = ["passCode": passCodeValue , "personnelId": doctorPersonnelID]
                    
                    WebAPIManager.sharedInstance.postApiCall(GlobalConstants.GetPatientData.getAllPatient,
                                                             params:params,
                                                             result:{(resultObject) -> Void in
                                                                print("Patient's Data Received")
                                                                
                                                                print(resultObject)
                                                                
                                                                dispatch_async(dispatch_get_main_queue(), {
                                                                    
                                                                    Utility.sharedInstance.activityIndicator.stopAnimating()
                                                                    
                                                                    //                                                            self.updateUI(resultObject as! String)
                                                                    
                                                                })
                                                                
                                                                
                    })
                }
                else
                {
                    
                    // create the alert
                    let alert = UIAlertController(title: "Wrong Passcode", message: "Please enter correct passcode \(doctorInfo.passcode)", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    
                    // show the alert
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                }
            }
            else
            {
                self.view.makeToast(message:"Please Enter Pass Code", duration:1.0, position:HRToastPositionDefault)
                return
            }
            
        }
    }

    @IBAction func actionForgetPasscode(sender: AnyObject)
    {
    
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

extension DrDB_PasscodeViewController : UITextFieldDelegate{
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        // On inputing value to textfield
        if (textField.text?.characters.count < 1  && string.characters.count > 0){
            let nextTag = textField.tag + 1;
            
            // get next responder
            var nextResponder = textField.superview?.viewWithTag(nextTag);
            
            if (nextResponder == nil){
                nextResponder = textField.superview?.viewWithTag(1);
            }
            textField.text = string;
            nextResponder?.becomeFirstResponder();
            return false;
        }
        else if (textField.text?.characters.count >= 1  && string.characters.count == 0){
            // on deleteing value from Textfield
            let previousTag = textField.tag - 1;
            
            // get next responder
            var previousResponder = textField.superview?.viewWithTag(previousTag);
            
            if (previousResponder == nil){
                previousResponder = textField.superview?.viewWithTag(1);
            }
            textField.text = "";
            previousResponder?.becomeFirstResponder();
            return false;
        }
        return false;
    }
}

