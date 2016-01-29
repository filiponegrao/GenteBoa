//
//  Login_ViewController.swift
//  GenteBoa
//
//  Created by Filipo Negrao on 01/11/15.
//  Copyright © 2015 Filipo Negrao. All rights reserved.
//

import UIKit

class Login_ViewController: UIViewController
{
    let backgroundColor = UIColor(hex: 0x4987af)
    
    var background : UIImageView!
    
    var logo : UIImageView!
    
    var button : UIButton!
    
    var register : UIButton!
    
    var loadingView : LoadingView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = self.backgroundColor
        
        self.background = UIImageView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        self.background.image = UIImage(named: "fundo")
        self.background.contentMode = .ScaleAspectFill
        self.view.addSubview(self.background)
        
        self.logo = UIImageView(frame: CGRectMake(0, 0, screenWidth/1.3, screenWidth/4))
        self.logo.image = UIImage(named: "GenteBoaLogo")
        self.logo.contentMode = .ScaleAspectFit
        self.logo.center = CGPointMake(screenWidth/2, screenHeight/3)
        self.view.addSubview(self.logo)
        
        
        self.button = UIButton(frame: CGRectMake(0, 0, screenWidth/1.3, screenWidth/6))
        self.button.center = CGPointMake(screenWidth/2, screenHeight/1.3)
//        self.button.setTitle("Logar com Facebook", forState: .Normal)
        self.button.setImage(UIImage(named: "loginFacebook"), forState: .Normal)
        self.button.addTarget(self, action: "login", forControlEvents: .TouchUpInside)
        self.button.layer.cornerRadius = 5
        self.button.layer.shadowColor = UIColor.blackColor().CGColor
        self.button.layer.shadowOffset = CGSizeMake(1, 1)
        self.button.layer.shadowRadius = 4
        self.button.layer.shadowOpacity = 0.7
        self.button.layer.masksToBounds = false
        self.button.layer.shadowPath = UIBezierPath(roundedRect: self.button.bounds, cornerRadius: self.button.layer.cornerRadius).CGPath

        self.view.addSubview(self.button)
        
        
        self.register = UIButton(frame: CGRectMake(0,0,screenWidth/1.5,screenWidth/8))
        self.register.center = CGPointMake(self.button.center.x, self.button.center.y - 80)
        self.register.addTarget(self, action: "registerUser", forControlEvents: .TouchUpInside)
        self.register.setTitle("Registrar", forState: .Normal)
        self.register.backgroundColor = UIColor(hex:0x408745)
        self.register.layer.cornerRadius = 5
//        self.view.addSubview(self.register)
        
    }
    
    override func viewWillAppear(animated: Bool)
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UserCondition.incompleteRegister.rawValue, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "incompleteRegister", name: UserCondition.incompleteRegister.rawValue, object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UserCondition.userLogged.rawValue, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "logged", name: UserCondition.userLogged.rawValue, object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UserCondition.loginCanceled.rawValue, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loginCanceled", name: UserCondition.loginCanceled.rawValue, object: nil)
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    func login()
    {
        self.loadingView = LoadingView()
        self.view.addSubview(self.loadingView)
        DAOUser.sharedInstance.loginFaceParse()
    }
    
    func incompleteRegister()
    {
        self.presentViewController(Register_ViewController(), animated: true) { () -> Void in
            
        }
    }
    
    func logged()
    {
        self.loadingView?.removeFromSuperview()
        let home = Home_ViewController()
        let nav = UINavigationController()
        nav.viewControllers = [home]
        self.presentViewController(nav, animated: true) { () -> Void in
            
        }
    }
    
    func loginCanceled()
    {
        self.loadingView.removeFromSuperview()
    }
    
    func registerUser()
    {
        self.loadingView?.removeFromSuperview()
        let newuser = NewLogin_ViewController()
        self.presentViewController(newuser, animated: true) { () -> Void in
            
        }
    }
    
    
}
