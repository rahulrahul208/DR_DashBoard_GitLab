//
//  ActivityIndicator.swift
//  bro4u
//
//  Created by Mac on 21/03/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import UIKit

class ActivityIndicator: UIView {

    // MARK - Variables
    
    lazy private var animationLayer : CALayer = {
        return CALayer()
    }()
    
    var isAnimating : Bool = false
    var hidesWhenStopped : Bool = true
    
    // MARK - Init
    
    init(image : UIImage) {
        
        let frame : CGRect = CGRectMake(0.0, 0.0, image.size.width/2, image.size.height/2)
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        
        let image1: UIImage = UIImage(named: "spinnerUp")!
        let imgView:UIImageView = UIImageView(image:image1)
        imgView.frame = CGRectMake(0, 0, image1.size.width/2, image1.size.height/2)
        self.addSubview(imgView)
        
        animationLayer.frame = frame
        animationLayer.contents = image.CGImage
        animationLayer.masksToBounds = true
        
        self.layer.addSublayer(animationLayer)
        
        addRotation(forLayer: animationLayer)
        pause(layer: animationLayer)
        self.hidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK - Func
    
    func addRotation(forLayer layer : CALayer) {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath:"transform.rotation.z")
        
        rotation.duration = 1.0
        rotation.removedOnCompletion = false
        rotation.repeatCount = HUGE
        rotation.fillMode = kCAFillModeForwards
        rotation.fromValue = NSNumber(float: 0.0)
        rotation.toValue = NSNumber(float: 3.14 * 2.0)
        
        layer.addAnimation(rotation, forKey: "rotate")
    }
    
    func pause(layer layer : CALayer) {
        let pausedTime = layer.convertTime(CACurrentMediaTime(), fromLayer: nil)
        
        layer.speed = 0.0
        layer.timeOffset = pausedTime
        
        isAnimating = false
    }
    
    func resume(layer layer : CALayer) {
        let pausedTime : CFTimeInterval = layer.timeOffset
        
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), fromLayer: nil) - pausedTime
        layer.beginTime = timeSincePause
        
        isAnimating = true
    }
    
    func startAnimating () {
        
        if isAnimating {
            return
        }
        
        if hidesWhenStopped {
            self.hidden = false
        }
        resume(layer: animationLayer)
    }
    
    func stopAnimating () {
        if hidesWhenStopped {
            self.hidden = true
        }
        pause(layer: animationLayer)
    }


}
