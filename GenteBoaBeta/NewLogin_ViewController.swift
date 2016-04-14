//
//  NewLogin_ViewController.swift
//  GenteBoaBeta
//
//  Created by Filipo Negrao on 07/11/15.
//  Copyright © 2015 Filipo Negrao. All rights reserved.
//

import Foundation
import UIKit

class NewLogin_ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{

    var name : UITextField!
    
    var email : UITextField!
    
    var password : UITextField!
    
    var profileImage : UIImage!
    
    var imagepicker : UIImagePickerController!
    
    var imageButton : UIButton!
    
    let margem = screenWidth*0.2
    
    var confirmButton : UIButton!
    
    var loadingVew : LoadingView!
    
    var backButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()

        self.imageButton = UIButton(frame: CGRectMake(screenWidth/2 - screenWidth/4, 50, screenWidth/2,screenWidth/2))
//        self.imageButton.center = CGPointMake(screenWidth/2, self.imageButton.frame.size.width/2 + 20)
        self.imageButton.layer.cornerRadius = self.imageButton.frame.size.width/2
        self.imageButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.imageButton.layer.borderWidth = 0.5
        self.imageButton.setTitle("Edit", forState: .Normal)
        self.imageButton.titleLabel?.textColor = UIColor.grayColor()
        self.imageButton.addTarget(self, action: "editphoto", forControlEvents: .TouchUpInside)
        self.imageButton.clipsToBounds = true
        self.imageButton.imageView?.contentMode = .ScaleAspectFill
        self.view.addSubview(self.imageButton)
        
        
        self.name = UITextField(frame: CGRectMake(self.margem, self.imageButton.frame.origin.y + self.imageButton.frame.size.height + 30, screenWidth - self.margem*2 ,44))
        self.name.placeholder = "Nome"
        self.name.borderStyle = .RoundedRect
        self.name.delegate = self
        self.name.textColor = GMColor.green700Color()
        self.name.autocorrectionType = .No
        self.view.addSubview(self.name)
        
        self.email = UITextField(frame: CGRectMake(self.margem, self.name.frame.origin.y + self.name.frame.size.height + 10, screenWidth - self.margem*2, 44))
        self.email.placeholder = "Email"
        self.email.delegate = self
        self.email.keyboardType = .EmailAddress
        self.email.textColor = GMColor.green700Color()
        self.email.autocapitalizationType = .None
        self.email.borderStyle = .RoundedRect
        self.email.autocorrectionType = .No
        self.view.addSubview(self.email)
        
        self.password = UITextField(frame: CGRectMake(self.margem, self.email.frame.origin.y + self.email.frame.size.height + 10, screenWidth - self.margem*2, 44))
        self.password.delegate = self
        self.password.placeholder = "Senha"
        self.password.borderStyle = .RoundedRect
        self.password.secureTextEntry = true
        self.password.textColor = GMColor.green700Color()
        self.password.keyboardType = .Default
        self.view.addSubview(self.password)
        
        
        self.confirmButton = UIButton(frame: CGRectMake(20, screenHeight - 50, screenWidth - 40, 40))
        self.confirmButton.setTitle("Pronto", forState: .Normal)
        self.confirmButton.addTarget(self, action: "done", forControlEvents: .TouchUpInside)
        self.confirmButton.backgroundColor = UIColor(hex: 0x408745)
        self.confirmButton.layer.cornerRadius = 5
        self.view.addSubview(self.confirmButton)
        
        self.backButton = UIButton(frame: CGRectMake(10,20, 80, 44))
        self.backButton.setTitle("Voltar", forState: .Normal)
        self.backButton.setTitleColor(GMColor.green700Color(), forState: .Normal)
        self.backButton.addTarget(self, action: "back", forControlEvents: .TouchUpInside)
        self.view.addSubview(self.backButton)
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool)
    {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NewLogin_ViewController.register), name: UserCondition.userLogged.rawValue, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NewLogin_ViewController.userAlreadyExist), name: UserCondition.userAlreadyExist.rawValue, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NewLogin_ViewController.unknowError), name: UserCondition.unknowError.rawValue, object: nil)


    }
    
    override func viewWillDisappear(animated: Bool)
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    //Sobe a view e desce a view
    func keyboardWillShow(notification: NSNotification)
    {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue()
        {
            self.view.frame.origin.y = -keyboardSize.height
        }
    }
    
    func keyboardWillHide(notification: NSNotification)
    {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue()
        {
            self.view.frame.origin.y = 0
        }
        
    }

    
    func editphoto()
    {
        let sheet = UIAlertController(title: "Choose picture", message: nil, preferredStyle: .ActionSheet)
        sheet.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { (action: UIAlertAction) -> Void in
            
            self.imagepicker = UIImagePickerController()
            self.imagepicker.sourceType = .Camera
            self.imagepicker.delegate = self
            self.imagepicker.cameraCaptureMode = .Photo
            self.imagepicker.cameraDevice = .Front
            
            self.presentViewController(self.imagepicker, animated: true) { () -> Void in
                
            }
            
        }))
        
        sheet.addAction(UIAlertAction(title: "Photo Album", style: .Default, handler: { (action: UIAlertAction) -> Void in
            
            self.imagepicker = UIImagePickerController()
            self.imagepicker.sourceType = .PhotoLibrary
            self.imagepicker.delegate = self
            
            self.presentViewController(self.imagepicker, animated: true) { () -> Void in
                
            }
            
        }))
        
        self.presentViewController(sheet, animated: true) { () -> Void in
            
        }
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?)
    {
        self.imagepicker.dismissViewControllerAnimated(true) { () -> Void in
            self.profileImage = image
            self.imageButton.setImage(image, forState: .Normal)

        }
    }
    
    func done()
    {
        if(self.name.text != "" && self.email.text != "" && self.password.text != "" && self.profileImage != nil)
        {
            self.loadingVew = LoadingView()
            self.view.addSubview(self.loadingVew)
            DAOUser.sharedInstance.registerUser(self.name.text!, email: self.email.text!, password: self.password.text!, photo: self.profileImage)
        }
        else
        {
            let alert = UIAlertController(title: "Ops!", message: "Preencha as informações corretamente! Verifique o campo de nome, email, senha e a imagem de perfil!", preferredStyle: .Alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: { (action: UIAlertAction) in
                
            }))
            
            self.presentViewController(alert, animated: true, completion: { 
                
            })
            
        }
        
    }
    
    func register()
    {
        self.loadingVew?.removeFromSuperview()
        self.presentViewController(EditPerfil_ViewController(), animated: true) { () -> Void in
            
        }
    }
    
    func userAlreadyExist()
    {
        self.loadingVew?.removeFromSuperview()
        SweetAlert().showAlert("Erro!", subTitle: "Usuário ja existe!", style: AlertStyle.Error, buttonTitle:"Ok", buttonColor: GMColor.orange300Color())

    }
    
    func unknowError()
    {
        self.loadingVew?.removeFromSuperview()
        SweetAlert().showAlert("Erro!", subTitle: "Um erro inesperado ocorreu! Tente novamente ou reinicie o app.", style: AlertStyle.Error, buttonTitle:"Ok", buttonColor: GMColor.orange300Color())

    }
    
    func back()
    {
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
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
