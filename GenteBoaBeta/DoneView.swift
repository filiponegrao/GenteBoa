//
//  DoneView.swift
//  GenteBoaBeta
//
//  Created by Filipo Negrao on 17/11/15.
//  Copyright © 2015 Filipo Negrao. All rights reserved.
//

import Foundation
import UIKit

class DoneView : UIView
{
    var blacscreen : UIView!
    
    var container : UIView!
    
    var title : UILabel!
    
    var imageView : UIImageView!
    
    var message : UILabel!
    
    
    var controller : UIViewController!
    
    init(controller : UIViewController)
    {
        self.controller = controller
        super.init(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        
        self.blacscreen = UIView(frame: self.frame)
        self.blacscreen.backgroundColor = UIColor.blackColor()
        self.blacscreen.alpha = 0.7
        self.addSubview(self.blacscreen)
        
        self.container = UIView(frame: CGRectMake(10,20,screenWidth - 20, screenHeight - 40))
        self.container.backgroundColor = GMColor.green900Color()
        self.container.layer.cornerRadius = 10
        self.container.layer.borderWidth = 1
        self.container.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "done"))
        self.addSubview(self.container)
        
        self.title = UILabel(frame: CGRectMake(0,0,screenWidth,screenHeight/5))
        self.title.text = "Obrigado pelo \nfeedback!"
        self.title.numberOfLines = 2
        self.title.textColor = UIColor.whiteColor()
        self.title.font = UIFont(name: "Arial Rounded MT Bold", size: 30)
        self.title.textAlignment = .Center
        self.container.addSubview(self.title)
        
        let adendo = UILabel(frame: CGRectMake(0,self.title.frame.origin.y + self.title.frame.size.height + 10,screenWidth, 60))
        adendo.text = "Seu feedback pode demorar \nalguns segundos para ser processado"
        adendo.numberOfLines = 2
        adendo.font = UIFont(name: "Helvetica", size: 12)
        adendo.textAlignment = .Center
        adendo.textColor = UIColor.whiteColor()
        self.container.addSubview(adendo)
        
        
        self.imageView = UIImageView(frame: CGRectMake(0, 0, screenWidth/2, screenWidth/2))
        self.imageView.center = CGPointMake(screenWidth/2, self.title.frame.origin.y + self.title.frame.size.height + self.imageView.frame.size.height)
        self.imageView.image = UIImage(named: "certo")
        self.imageView.contentMode = .ScaleAspectFit
        self.container.addSubview(self.imageView)
        
        
        self.message = UILabel(frame: CGRectMake(20, screenHeight/2, screenWidth - 40, screenHeight/2))
        self.message.text = "Voce é \nGENTE BOA"
        self.message.textColor = UIColor.whiteColor()
        self.message.textAlignment = .Center
        self.message.numberOfLines = 2
        self.message.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        self.container.addSubview(self.message)
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func done()
    {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            self.alpha = 0
            
            }) { (success: Bool) -> Void in
                
                self.controller.dismissViewControllerAnimated(true, completion: { () -> Void in
                    
                })
        }
    }
    
}


