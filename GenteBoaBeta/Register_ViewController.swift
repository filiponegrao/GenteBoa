//
//  Register_ViewController.swift
//  GenteBoa
//
//  Created by Filipo Negrao on 01/11/15.
//  Copyright © 2015 Filipo Negrao. All rights reserved.
//

import UIKit

class Register_ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate
{
    let faculdades = ["PUC-Rio Gávea"]
    
    let cursos = Cursos.cursosDisponiveis()
    
    let periodos = Periodos.periodosDisponiveis()

    var textFieldUniversity : UITextField!
    
    var textFieldCourse : UITextField!
    
    var textFieldPeriod : UITextField!
    
    var textView : UITextView!
    
    var doneButton : UIButton!
    
    var pickerView1 : UIPickerView!
    
    var pickerView2 : UIPickerView!

    var pickerView3 : UIPickerView!
    
    var periodo : Int = 0
    
    var loadingView : LoadingView!

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = GMColor.green900Color()
        
        self.pickerView1 = UIPickerView()
        self.pickerView1.delegate = self
        
        self.pickerView2 = UIPickerView()
        self.pickerView2.delegate = self
        
        self.pickerView3 = UIPickerView()
        self.pickerView3.delegate = self
        
        let title = UILabel(frame: CGRectMake(0,40,screenWidth,40))
        title.text = "Complete suas informações"
        title.textColor = UIColor.whiteColor()
        title.textAlignment = .Center
        self.view.addSubview(title)
        
        self.textFieldUniversity = UITextField(frame: CGRectMake(0,0, screenWidth/1.3,40))
        self.textFieldUniversity.center = CGPointMake(screenWidth/2, screenHeight/4)
        self.textFieldUniversity.borderStyle = .RoundedRect
        self.textFieldUniversity.delegate = self
        self.textFieldUniversity.placeholder = "Sua Universidade"
        self.textFieldUniversity.inputView = self.pickerView1
        self.view.addSubview(self.textFieldUniversity)
        
        self.textFieldCourse = UITextField(frame: CGRectMake(0,0, screenWidth/1.3,40))
        self.textFieldCourse.center = CGPointMake(screenWidth/2, self.textFieldUniversity.frame.origin.y + 80)
        self.textFieldCourse.borderStyle = .RoundedRect
        self.textFieldCourse.delegate = self
        self.textFieldCourse.placeholder = "Seu Curso"
        self.textFieldCourse.inputView = self.pickerView2
        self.textFieldCourse.adjustsFontSizeToFitWidth = true
//        self.textFieldCourse.minimumScaleFactor = 0.2
        self.view.addSubview(self.textFieldCourse)
        
        
        self.textFieldPeriod = UITextField(frame: CGRectMake(0,0, screenWidth/1.3,40))
        self.textFieldPeriod.center = CGPointMake(screenWidth/2, self.textFieldCourse.frame.origin.y + 80)
        self.textFieldPeriod.borderStyle = .RoundedRect
        self.textFieldPeriod.delegate = self
        self.textFieldPeriod.placeholder = "Seu Periodo"
        self.textFieldPeriod.inputView = self.pickerView3
        self.view.addSubview(self.textFieldPeriod)
        
        self.textView = UITextView(frame: CGRectMake((screenWidth - screenWidth/1.3)/2, screenHeight - screenHeight/3 - 80, screenWidth/1.3, screenHeight/3))
        self.textView.backgroundColor = UIColor.whiteColor()
        self.textView.layer.cornerRadius = 5
        self.textView.layer.borderWidth = 0.5
        self.textView.layer.borderColor = UIColor.grayColor().CGColor
        self.textView.text = "Fale mais sobre voce..."
        self.textView.textColor = UIColor.grayColor()
        self.textView.font = UIFont(name: "Helvetica", size: 14)
        self.textView.delegate = self
        self.view.addSubview(self.textView)
        
        self.doneButton = UIButton(frame: CGRectMake(0,screenHeight - 50, screenWidth, 50))
        self.doneButton.backgroundColor = GMColor.orange300Color()
        self.doneButton.setTitle("Terminar", forState: .Normal)
        self.doneButton.addTarget(self, action: "done", forControlEvents: .TouchUpInside)
        self.view.addSubview(self.doneButton)

    }

    
    override func viewWillAppear(animated: Bool)
    {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "logado", name: UserCondition.userLogged.rawValue, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UserCondition.userLogged.rawValue, object: nil)
    }
    
    //Sobe a view e desce a view
    func keyboardWillShow(notification: NSNotification)
    {
        if(self.textFieldPeriod.editing || self.textView.isFirstResponder())
        {
            if(self.view.frame.origin.y == 0)
            {
                if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                    self.view.frame.origin.y = -keyboardSize.height
                }
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        UIView.animateWithDuration(0.3) { () -> Void in
            self.view.frame.origin.y = 0
        }
    }

    func textViewDidBeginEditing(textView: UITextView)
    {
        if(textView.text == "Fale mais sobre voce...")
        {
            self.textView.text = ""
            self.textView.textColor = UIColor.blackColor()
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //** PICKER VIEW **//
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        switch pickerView
        {
        case self.pickerView1:
            return self.faculdades.count
            
        case self.pickerView2:
            return self.cursos.count
            
        case self.pickerView3:
            return self.periodos.count
            
        default:
            return 0
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
//    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
//    {
//        switch pickerView
//        {
//        case self.pickerView1:
//            return self.faculdades[row]
//            
//        case self.pickerView2:
//            return self.cursos[row]
//            
//        case self.pickerView3:
//            return "\(self.periodos[row])º Período"
//            
//        default:
//            return ""
//        }
//    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let label = UILabel(frame: CGRectMake(0,0,screenWidth, 44))
        label.backgroundColor = UIColor.clearColor()
        label.textAlignment = .Center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        
        switch pickerView
        {
        case self.pickerView1:
            label.text =  self.faculdades[row]
            
        case self.pickerView2:
            label.text = self.cursos[row]
            
        case self.pickerView3:
            label.text = "\(self.periodos[row])º Período"
            
        default:
            label.text = ""
        }
        
        return label
    }
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        switch pickerView
        {
        case self.pickerView1:
            self.textFieldUniversity.text = self.faculdades[row]
            self.textFieldUniversity.endEditing(true)
            
        case self.pickerView2:
            self.textFieldCourse.text = self.cursos[row]
            
        case self.pickerView3:
            self.textFieldPeriod.text = "\(self.periodos[row])º Período"
            self.periodo = self.periodos[row]
            
        default: break
            
        }
    }
    
    
    func done()
    {
        if(self.textFieldCourse.text != "" && self.textFieldPeriod.text != "" && self.textFieldUniversity.text != "" && (self.textView.text != "" && self.textView.text != "Fale mais sobre voce..."))
        {
            self.loadingView = LoadingView()
            self.view.addSubview(self.loadingView)
            DAOUser.sharedInstance.configUserFace(self.textFieldUniversity.text!, course: self.textFieldCourse.text!, period: self.periodo, about: self.textView.text!)
        }
        else
        {
            let alert = UIAlertController(title: "Campos incompletos", message: "Complete os campos corretamente antes de continuar", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction) -> Void in
                
            }))
            self.showViewController(alert, sender: self)
        }
    }
    
    func logado()
    {
        self.loadingView?.removeFromSuperview()
        let home = Home_ViewController()
        
        let nav = UINavigationController()
        nav.viewControllers = [home]
        
        self.presentViewController(nav, animated: true, completion: nil)
    }
}


