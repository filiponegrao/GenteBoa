//
//  LoadingView.swift
//  GenteBoaBeta
//
//  Created by Filipo Negrao on 15/11/15.
//  Copyright © 2015 Filipo Negrao. All rights reserved.
//

import Foundation
import UIKit


class LoadingView : UIView
{
    var blackScreen : UIView!
    
    var activity : NVActivityIndicatorView!
    
    init()
    {
        super.init(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        
        self.blackScreen = UIView(frame: CGRectMake(0,0,screenWidth,screenHeight))
        self.blackScreen.backgroundColor = UIColor.blackColor()
        self.blackScreen.alpha = 0.7
        self.addSubview(self.blackScreen)
        
        self.activity = NVActivityIndicatorView(frame: CGRectMake(0, 0, 60, 60), type: NVActivityIndicatorType.SemiCircleSpin, color: UIColor.whiteColor())
        self.activity.center = self.center
        self.activity.animating = true
        self.activity.startAnimation()
        self.addSubview(self.activity)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}