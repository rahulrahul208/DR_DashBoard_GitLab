//
//  DrDB_WarningsViewController.swift
//  NewDrDashBoard
//
//  Created by MACBookPro on 8/16/16.
//  Copyright © 2016 cognizant. All rights reserved.
//

import UIKit

class DrDB_WarningsViewController: UIViewController {

    @IBOutlet weak var lblPatientName:UILabel!
    @IBOutlet weak var lblOperationPerformed:UILabel!
    @IBOutlet weak var lblPod:UILabel!
    @IBOutlet weak var btnDone:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Do any additional setup after loading the view.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


extension DrDB_WarningsViewController : UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let warningCell = tableView.dequeueReusableCellWithIdentifier("WarningsTableViewCellID", forIndexPath: indexPath) as! DrDB_WarningsTableViewCell
        
        
        
        return warningCell
    }
}

extension DrDB_WarningsViewController : UITableViewDelegate{
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
}

