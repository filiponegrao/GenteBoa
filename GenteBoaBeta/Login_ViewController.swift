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
    
    var textLogin : MKTextField!
    
    var textPassword : MKTextField!
    
    var loginButton : UIButton!
    
    var facebookButton : UIButton!
    
    var register : UIButton!
    
    var loadingView : LoadingView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(hex: 0x1b3e20)
        
        self.background = UIImageView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        self.background.image = UIImage(named: "fundo")
        self.background.contentMode = .ScaleAspectFill
        self.background.alpha = 0.05
        self.view.addSubview(self.background)
        
        self.logo = UIImageView(frame: CGRectMake(0, 0, screenWidth/1.3, screenWidth/5))
        self.logo.image = UIImage(named: "GenteBoaLogo")
        self.logo.contentMode = .ScaleAspectFit
        self.logo.center = CGPointMake(screenWidth/2, screenHeight/4)
        self.view.addSubview(self.logo)
        
        self.textLogin = MKTextField(frame: CGRectMake((screenWidth - (screenWidth/1.3))/2, self.logo.frame.origin.y + self.logo.frame.size.height + 30, screenWidth/1.3, screenWidth/10))
        self.textLogin.backgroundColor = UIColor.whiteColor()
        self.textLogin.placeholder = "email"
        self.textLogin.keyboardType = .EmailAddress
        self.textLogin.borderStyle = .RoundedRect
        self.textLogin.textColor = GMColor.green900Color()
        self.textLogin.autocapitalizationType = .None
        self.textLogin.autocorrectionType = .No
        self.view.addSubview(self.textLogin)
        
        self.textPassword = MKTextField(frame: CGRectMake((screenWidth - (screenWidth/1.3))/2, self.textLogin.frame.origin.y + self.textLogin.frame.size.height + 20, screenWidth/1.3, screenWidth/10))
        self.textPassword.backgroundColor = UIColor.whiteColor()
        self.textPassword.placeholder = "password"
        self.textPassword.secureTextEntry = true
        self.textPassword.borderStyle = .RoundedRect
        self.textPassword.textColor = GMColor.green900Color()
        self.view.addSubview(self.textPassword)
        
        self.loginButton = UIButton(frame: CGRectMake((screenWidth - (screenWidth/1.3))/2, self.textPassword.frame.origin.y + self.textPassword.frame.size.height + 20, screenWidth/1.3, screenWidth/8))
        self.loginButton.backgroundColor = GMColor.orange700Color()
        self.loginButton.setTitle("Login", forState: .Normal)
        self.loginButton.layer.cornerRadius = 5
        self.loginButton.addTarget(self, action: "login", forControlEvents: .TouchUpInside)
        self.view.addSubview(self.loginButton)
        
        self.facebookButton = UIButton(frame: CGRectMake(0, 0, screenWidth/1.3, screenWidth/6))
        self.facebookButton.center = CGPointMake(screenWidth/2, screenHeight/1.3)
//        self.button.setTitle("Logar com Facebook", forState: .Normal)
        self.facebookButton.setImage(UIImage(named: "loginFacebook"), forState: .Normal)
        self.facebookButton.addTarget(self, action: "faceLogin", forControlEvents: .TouchUpInside)
        self.facebookButton.layer.cornerRadius = 5
        self.facebookButton.layer.shadowColor = UIColor.blackColor().CGColor
        self.facebookButton.layer.shadowOffset = CGSizeMake(1, 1)
        self.facebookButton.layer.shadowRadius = 4
        self.facebookButton.layer.shadowOpacity = 0.3
        self.facebookButton.layer.masksToBounds = false
        self.facebookButton.layer.shadowPath = UIBezierPath(roundedRect: self.facebookButton.bounds, cornerRadius: self.facebookButton.layer.cornerRadius).CGPath

        self.view.addSubview(self.facebookButton)
        
        
        self.register = UIButton(frame: CGRectMake(self.facebookButton.frame.origin.x , self.facebookButton.frame.origin.y + self.facebookButton.frame.size.height + 20 ,screenWidth/1.3,screenWidth/6))
        self.register.addTarget(self, action: "registerUser", forControlEvents: .TouchUpInside)
        self.register.setTitle("Criar conta", forState: .Normal)
//        self.register.backgroundColor = UIColor(hex:0x408745)
        self.register.layer.cornerRadius = 5
        self.view.addSubview(self.register)
        
    }

    override func viewDidAppear(animated: Bool)
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UserCondition.incompleteRegister.rawValue, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "incompleteRegister", name: UserCondition.incompleteRegister.rawValue, object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UserCondition.userLogged.rawValue, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "logged", name: UserCondition.userLogged.rawValue, object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UserCondition.loginCanceled.rawValue, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loginCanceled", name: UserCondition.loginCanceled.rawValue, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userNotFound", name: UserCondition.userNotFound.rawValue, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "wrongPassword", name: UserCondition.wrongPassword.rawValue, object: nil)
    }
    
    override func viewDidDisappear(animated: Bool)
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    func faceLogin()
    {
        self.loadingView = LoadingView()
        self.view.addSubview(self.loadingView)
        DAOUser.sharedInstance.loginFaceParse()
    }
    
    func incompleteRegister()
    {
        self.presentViewController(EditPerfil_ViewController(), animated: true) { () -> Void in
            
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
    
    func login()
    {
        if(self.textLogin.text != "" && self.textPassword.text != "" && DAOUser.sharedInstance.isValidEmail(self.textLogin.text!) && !self.verifyWhiteSpace(self.textLogin.text!) && !self.verifyWhiteSpace(self.textPassword.text!) && !self.verifySpecialCharacter(self.textPassword.text!) && !self.verifySpecialCharacter(self.textLogin.text!))
        {
            self.loadingView?.removeFromSuperview()
            self.loadingView = LoadingView()
            self.view.addSubview(self.loadingView)
            DAOUser.sharedInstance.loginParse(self.textLogin.text!, password: self.textPassword.text!)
        }
        else
        {
            SweetAlert().showAlert("Erro!", subTitle: "Preencha corretamente os campos!", style: AlertStyle.Error, buttonTitle:"Ok", buttonColor: GMColor.orange300Color())

        }
    }
    
    func userNotFound()
    {
        self.loadingView?.removeFromSuperview()
        SweetAlert().showAlert("Erro!", subTitle: "Uusuario ou senha incorretos!", style: AlertStyle.Error, buttonTitle:"Ok", buttonColor: GMColor.orange300Color())

    }
    
    func wrongPassword()
    {
        self.loadingView?.removeFromSuperview()
        SweetAlert().showAlert("Erro!", subTitle: "Senha incorreta!", style: AlertStyle.Error, buttonTitle:"Ok", buttonColor: GMColor.orange300Color())

    }
    
    func verifySpecialCharacter(username: String) -> Bool
    {
        let characterSet:NSCharacterSet = NSCharacterSet(charactersInString: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789@_.-")
        let searchTerm = username
        if ((searchTerm.rangeOfCharacterFromSet(characterSet.invertedSet)) != nil)
        {
            print("special characters found")
            return true
        }
        return false
    }
    
    func verifyWhiteSpace (username: String) -> Bool
    {
        let whitespace = NSCharacterSet.whitespaceCharacterSet()
        
        let range = username.rangeOfCharacterFromSet(whitespace)
        
        // range will be nil if no whitespace is found
        if (range != nil) {
            print("whitespace found")
            return true
        }
        else
        {
            print("whitespace not found")
            return false
        }
    }
}
