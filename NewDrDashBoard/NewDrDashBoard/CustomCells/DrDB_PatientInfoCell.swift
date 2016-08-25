//
//  DrDB_PatientInfoCell.swift
//  Dashboard-iKare
//
//  Created by shahnawaz on 30/05/2016.
//  Copyright © 2016 shahnawaz. All rights reserved.
//

import UIKit

class DrDB_PatientInfoCell: UITableViewCell {

    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var lblOperationPerformed:UILabel!
    @IBOutlet weak var lblDiagnosis:UILabel!
    @IBOutlet weak var lblPod:UILabel!
    @IBOutlet weak var btnWhatsApp:UIButton!
    @IBOutlet weak var btnCall:UIButton!
    @IBOutlet weak var btnWarning:UIButton!
    @IBOutlet weak var buttonScroll: UIScrollView!

    var elementAlertArr : [DrDB_ParameterValueModel] = []
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        alertCount.layer.cornerRadius = alertCount.frame.size.width/2
//        alertCount.clipsToBounds = true
//        alertCount.layer.borderWidth = 1.0
//        alertCount.layer.borderColor = UIColor.greenColor().CGColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureScrollView()
      {
        if self.elementAlertArr.count > 0 {
          
          let scrollingView = colorButtonsView(CGSizeMake(100.0,50.0), buttonCount: elementAlertArr.count)
          
          buttonScroll.contentSize = scrollingView.frame.size
          buttonScroll.addSubview(scrollingView)
          buttonScroll.showsHorizontalScrollIndicator = true
          buttonScroll.indicatorStyle = .Default

        }
          //scrolling pageview
      }
    
    func colorButtonsView(buttonSize:CGSize, buttonCount:Int) -> UIView {
        //creates color buttons in a UIView
        let buttonView = UIView()
        
        
        buttonView.backgroundColor = UIColor.lightGrayColor()
        buttonView.frame.origin = CGPointMake(0,0)
        
        let padding = CGSizeMake(10, 10)
        buttonView.frame.size.width = (buttonSize.width + padding.width) * CGFloat(buttonCount)
        buttonView.frame.size.height = (buttonSize.height +  2.0 * padding.height)
        
        //add buttons to the view
        var buttonPosition = CGPointMake(padding.width * 0.5, padding.height)
        let buttonIncrement = buttonSize.width + padding.width
        let hueIncrement = 1.0 / CGFloat(buttonCount)
        var newHue = hueIncrement
        
        
        for i in 0...(buttonCount - 1)  {
            let button = UIButton(type: UIButtonType.Custom) as UIButton
            
            button.frame.size = buttonSize
            button.frame.origin = buttonPosition
            buttonPosition.x = buttonPosition.x + buttonIncrement
            button.backgroundColor = UIColor.redColor()
            newHue = newHue + hueIncrement
          
            let titleLabel = UILabel(frame: CGRectMake(0, button.frame.origin.y-5, button.frame.width, button.frame.height-5))
            titleLabel.font = UIFont(name:"Helvetica-Bold", size: 13.0)
            titleLabel.textColor = UIColor.whiteColor()
            titleLabel.textAlignment = .Center
            titleLabel.backgroundColor = UIColor.darkGrayColor()
            titleLabel.numberOfLines = 2;
          
            let elementsDataDict: DrDB_ParameterValueModel =  elementAlertArr[i]
            if elementsDataDict.isAlert == "1"{
              titleLabel.text = " \(elementsDataDict.elementName!) \n \(elementsDataDict.elementValue!)"
            }
            button.addSubview(titleLabel)

            button.addTarget(self, action: "colorButtonPressed:", forControlEvents: .TouchUpInside)
            buttonView.addSubview(button)
//            self.initializeWithValue(button,buttonNumber: i)

        }
      
        return buttonView
    }

  func initializeWithValue(button : UIButton , buttonNumber :Int){
      
          let elementsDataDict: DrDB_ParameterValueModel =  elementAlertArr[buttonNumber]
          if elementsDataDict.isAlert == "1"{
            button.setTitle(" \(elementsDataDict.elementName!) \n \(elementsDataDict.elementValue!)", forState: UIControlState.Normal)
           }

    }

  
    func colorButtonPressed(sender:UIButton){
        buttonScroll.backgroundColor = sender.backgroundColor
    }



}
