//
//  AtencaoView.swift
//  GenteBoaBeta
//
//  Created by Filipo Negrao on 17/11/15.
//  Copyright © 2015 Filipo Negrao. All rights reserved.
//

import Foundation
import UIKit


class AtencaoView: UIView
{
    var blacscreen : UIView!
    
    var container : UIView!
    
    var title : UILabel!
    
    var intrduction : UILabel!
    
    var message : UILabel!
    
    var backButton : UIButton!
    
    var okButton : UIButton!
    
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
        self.addSubview(self.container)
        
        self.title = UILabel(frame: CGRectMake(0,0,screenWidth,screenHeight/5))
        self.title.text = "Atenção!"
        self.title.textColor = UIColor.whiteColor()
        self.title.font = UIFont(name: "Arial Rounded MT Bold", size: 30)
        self.title.textAlignment = .Center
        self.container.addSubview(self.title)
        
        self.intrduction = UILabel(frame: CGRectMake(20,self.title.frame.origin.y + self.title.frame.size.height + 20,self.container.frame.size.width - 40,screenHeight/5))
        self.intrduction.text = "Lembre-se que este aplicativo trata do ambiente de trabalho em equipe."
        self.intrduction.textColor = UIColor.whiteColor()
        self.intrduction.textAlignment = .Center
        self.intrduction.numberOfLines = 5
        self.container.addSubview(self.intrduction)
        
        self.message = UILabel(frame: CGRectMake(20,self.intrduction.frame.origin.y + self.intrduction.frame.size.height + 40,self.container.frame.size.width - 40,screenHeight/5))
        self.message.text = "Tem certeza que pode dar um feedback construtivo?"
        self.message.textColor = UIColor.whiteColor()
        self.message.textAlignment = .Center
        self.message.numberOfLines = 5
        self.message.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        self.container.addSubview(self.message)
        
        self.okButton = UIButton(frame: CGRectMake(0,0,self.container.frame.size.width/3,50))
        self.okButton.center = CGPointMake(self.container.frame.size.width*3/4, self.container.frame.size.height - 70)
        self.okButton.backgroundColor = UIColor.grayColor()
        self.okButton.setTitle("continuar", forState: .Normal)
        self.okButton.addTarget(self, action: "continuar", forControlEvents: .TouchUpInside)
        self.okButton.layer.cornerRadius = 5
        self.okButton.layer.borderWidth = 1
        self.container.addSubview(self.okButton)
        
        self.backButton = UIButton(frame: CGRectMake(0,0,self.container.frame.size.width/3,50))
        self.backButton.center = CGPointMake(self.container.frame.size.width*1/4, self.container.frame.size.height - 70)
        self.backButton.backgroundColor = UIColor.grayColor()
        self.backButton.setTitle("voltar", forState: .Normal)
        self.backButton.addTarget(self, action: "cancelar", forControlEvents: .TouchUpInside)
        self.backButton.layer.cornerRadius = 5
        self.backButton.layer.borderWidth = 1
        self.container.addSubview(self.backButton)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func continuar()
    {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            self.frame.size = CGSize(width: 1, height: 1)
//            self.center = self.superview!.center
            self.alpha = 0
            
            }) { (success: Bool) -> Void in
                
                self.removeFromSuperview()
        }
    }
    
    func cancelar()
    {
        controller.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
}