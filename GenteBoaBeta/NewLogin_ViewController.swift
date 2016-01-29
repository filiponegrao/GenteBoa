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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()

        self.imageButton = UIButton(frame: CGRectMake(0,0,screenWidth/2,screenWidth/2))
        self.imageButton.center = CGPointMake(screenWidth/2, self.imageButton.frame.size.width/2 + 20)
        self.imageButton.layer.cornerRadius = self.imageButton.frame.size.width/2
        self.imageButton.layer.borderColor = UIColor.grayColor().CGColor
        self.imageButton.layer.borderWidth = 1
        self.imageButton.setTitle("Edit", forState: .Normal)
        self.imageButton.titleLabel?.textColor = UIColor.grayColor()
        self.imageButton.addTarget(self, action: "editphoto", forControlEvents: .TouchUpInside)
        self.imageButton.clipsToBounds = true
        self.imageButton.imageView?.contentMode = .ScaleAspectFill
        self.view.addSubview(self.imageButton)
        
        
        self.name = UITextField(frame: CGRectMake(self.margem, self.imageButton.frame.origin.y + self.imageButton.frame.size.height + 10, screenWidth - self.margem*2 ,44))
        self.name.placeholder = "Nome"
        self.name.borderStyle = .RoundedRect
        self.name.delegate = self
        self.view.addSubview(self.name)
        
        self.email = UITextField(frame: CGRectMake(self.margem, self.name.frame.origin.y + self.name.frame.size.height + 10, screenWidth - self.margem*2, 44))
        self.email.placeholder = "Email"
        self.email.delegate = self
        self.email.borderStyle = .RoundedRect
        self.view.addSubview(self.email)
        
        self.password = UITextField(frame: CGRectMake(self.margem, self.email.frame.origin.y + self.email.frame.size.height + 10, screenWidth - self.margem*2, 44))
        self.password.delegate = self
        self.password.placeholder = "Senha"
        self.password.borderStyle = .RoundedRect
        self.view.addSubview(self.password)
        
        
        self.confirmButton = UIButton(frame: CGRectMake(20, screenHeight - 50, screenWidth - 40, 40))
        self.confirmButton.setTitle("Pronto", forState: .Normal)
        self.confirmButton.addTarget(self, action: "done", forControlEvents: .TouchUpInside)
        self.confirmButton.backgroundColor = UIColor(hex: 0x408745)
        self.view.addSubview(self.confirmButton)
        
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "register", name: UserCondition.userRegistered.rawValue, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UserCondition.userRegistered.rawValue, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    func editphoto()
    {
        self.imagepicker = UIImagePickerController()
        self.imagepicker.sourceType = .Camera
        self.imagepicker.delegate = self
        self.imagepicker.cameraCaptureMode = .Photo
        self.imagepicker.cameraDevice = .Front
        
        self.presentViewController(self.imagepicker, animated: true) { () -> Void in
            
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
        self.loadingVew = LoadingView()
        self.view.addSubview(self.loadingVew)
        DAOUser.sharedInstance.registerUser(self.name.text!, email: self.email.text!, password: self.password.text!, photo: self.profileImage)
    }
    
    func register()
    {
        self.loadingVew?.removeFromSuperview()
        self.presentViewController(Register_ViewController(), animated: true) { () -> Void in
            
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
