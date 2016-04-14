//
//  EditPerfil_ViewController.swift
//  GenteBoaBeta
//
//  Created by Filipo Negrao on 20/01/16.
//  Copyright © 2016 Filipo Negrao. All rights reserved.
//

import UIKit

class EditPerfil_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource
{
    
    var tableView : UITableView!
    
    var edit: Bool = false
    
    var button : UIButton!
    
    var universidade : UITextField!
    
    var curso : UITextField!
    
    var periodo : UITextField!
    
    var about : UITextView!
    
    var pickerView : UIPickerView!
    
    var loadingView : LoadingView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.title = "Minhas informações"
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Voltar", style: UIBarButtonItemStyle.Plain, target: self, action: "back")
        
        self.tableView = UITableView(frame: CGRectMake(0, 0, screenWidth, screenHeight - 60))
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.tableView)
        
        
        self.button = UIButton(frame: CGRectMake(0, screenHeight - 50, screenWidth, 50))
        self.button.backgroundColor = GMColor.green300Color()
        self.button.setTitle("Concluir", forState: .Normal)
        self.button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.button.setTitleColor(UIColor.grayColor(), forState: .Disabled)
        self.button.addTarget(self, action: "terminar", forControlEvents: .TouchUpInside)
        self.button.enabled = false
        self.view.addSubview(self.button)
        
        self.pickerView = UIPickerView()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        let tap = UITapGestureRecognizer(target: self, action: "endEditions")
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(animated: Bool)
    {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "done", name: UserCondition.userLogged.rawValue, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "error", name: UserCondition.unknowError.rawValue, object: nil)

    }
    
    override func viewWillDisappear(animated: Bool)
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //Sobe a view e desce a view
    func keyboardWillShow(notification: NSNotification)
    {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue()
        {
            if(self.curso.editing || self.periodo.editing)
            {
                self.tableView.contentOffset.y = keyboardSize.height/2
            }
            else if(self.about.isFirstResponder())
            {
                self.tableView.contentOffset.y = keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification)
    {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue()
        {
            self.tableView.contentOffset.y = 0
        }
        
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 5
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if(indexPath.row == 0)
        {
            return 100
        }
        else if(indexPath.row == 4)
        {
            return 120
        }
        else
        {
            return 80
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.selectionStyle = .None
        cell.backgroundColor = UIColor.whiteColor()
        
        while (cell.subviews.last?.removeFromSuperview() != nil) {}
        
        switch indexPath.row
        {
        case 0:
            
            let label = UILabel(frame: CGRectMake(20,10, screenWidth - 40, 80))
            label.text = "Para uma melhor experiência no aplicativo, mantenha suas informações sobre curso e período atualizadas."
            label.numberOfLines = 0
            label.textColor = UIColor.grayColor()
            label.font = UIFont(name: "Helvetica", size: 12)
            
            cell.addSubview(label)
            
        case 1:
            
            let titulo = UILabel(frame: CGRectMake(20,0,screenWidth - 20, 40))
            titulo.text = "Universidade"
            cell.addSubview(titulo)
            
            self.universidade = UITextField(frame: CGRectMake(10, titulo.frame.origin.y + titulo.frame.size.height, screenWidth - 20, 40))
            universidade.text = DAOUser.sharedInstance.getUniversity()
            universidade.textColor = UIColor.grayColor()
            universidade.borderStyle = .RoundedRect
            self.universidade.delegate = self
            self.universidade.inputView = self.pickerView
            
            cell.addSubview(universidade)
            
        case 2:
            
            let titulo = UILabel(frame: CGRectMake(20,0,screenWidth - 20, 40))
            titulo.text = "Curso"
            cell.addSubview(titulo)
            
            self.curso = UITextField(frame: CGRectMake(10, titulo.frame.origin.y + titulo.frame.size.height, screenWidth - 20, 40))
            curso.text = DAOUser.sharedInstance.getCourse()
            curso.adjustsFontSizeToFitWidth = true
            curso.textColor = UIColor.grayColor()
            curso.borderStyle = .RoundedRect
            self.curso.delegate = self
            self.curso.inputView = self.pickerView
            
            cell.addSubview(curso)
            
        case 3:
            
            let titulo = UILabel(frame: CGRectMake(20,0,screenWidth - 20, 40))
            titulo.text = "Período"
            cell.addSubview(titulo)
            
            self.periodo = UITextField(frame: CGRectMake(10, titulo.frame.origin.y + titulo.frame.size.height, screenWidth - 20, 40))
            
            self.periodo.text = "\(DAOUser.sharedInstance.getPeriod())"
            
            self.periodo.textColor = UIColor.grayColor()
            self.periodo.borderStyle = .RoundedRect
            self.periodo.delegate = self
            self.periodo.inputView = self.pickerView
            
            cell.addSubview(self.periodo)
            
        case 4:
            
            let titulo = UILabel(frame: CGRectMake(20,0,screenWidth - 20, 40))
            titulo.text = "Sobre mim"
            cell.addSubview(titulo)
            
            self.about = UITextView(frame: CGRectMake(10, titulo.frame.origin.y + titulo.frame.size.height, screenWidth - 20, 80))
            about.text = DAOUser.sharedInstance.getAbout()
            about.textColor = UIColor.grayColor()
            about.font = UIFont(name: "Helvetica", size: 14)
            self.about.layer.borderWidth = 0.5
            self.about.layer.borderColor = GMColor.grey300Color().CGColor
            self.about.layer.cornerRadius = 5
            self.about.delegate = self
            
            cell.addSubview(about)

            
        default: return cell
            
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(textField: UITextField)
    {
        self.button.enabled = true
        self.pickerView.reloadAllComponents()
        self.edit = true
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        self.button.enabled = true
    }
    
    func back()
    {
        if(self.edit)
        {
            let alert = UIAlertController(title: "Cancelar as edicoes?", message: "Tem certeza que deseja cancelar as edições?", preferredStyle: .Alert)
            
            alert.addAction(UIAlertAction(title: "Sim", style: .Default, handler: { (action: UIAlertAction) -> Void in
                
                self.navigationController?.popViewControllerAnimated(true)
            }))
            
            alert.addAction(UIAlertAction(title: "Não", style: .Cancel, handler: { (action: UIAlertAction) -> Void in
                
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else
        {
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    func terminar()
    {
        if(self.universidade.text?.characters.count != 0 && self.curso.text?.characters.count != 0 && self.periodo.text?.characters.count != 0 && self.about.text?.characters.count != 0 && self.about.text != "Gente boa" && self.universidade.text != "Gente boa" && self.periodo.text != "0")
        {
            self.loadingView = LoadingView()
            self.view.addSubview(self.loadingView)
            
            if(self.presentingViewController!.isKindOfClass(Login_ViewController))
            {
                DAOUser.sharedInstance.configUserFace(self.universidade.text!, course: self.curso.text!, period: Int(self.periodo.text!)!, about: self.about.text!)
            }
            else
            {
                DAOUser.sharedInstance.atualizarDados(self.universidade.text!, curso: self.curso.text!, periodo:  Int(self.periodo.text!)!, sobre: self.about.text!)
            }
        }
        else
        {
            let alert = UIAlertController(title: "Ops!", message: "Preencha os campos corretamente", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction) -> Void in
                
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func done()
    {
        self.loadingView?.removeFromSuperview()
        let alert = UIAlertController(title: "Sucesso!", message: "Dados atualizados com sucesso!", preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction) -> Void in
            
            if((self.presentingViewController?.isKindOfClass(Login_ViewController)) != nil)
            {
                let appdelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)

                
                let home = Home_ViewController()
                let nav = UINavigationController()
                nav.viewControllers = [home]
                appdelegate.window?.rootViewController = nav
            }
            else
            {
                self.navigationController?.popViewControllerAnimated(true)
            }
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func error()
    {
        self.loadingView?.removeFromSuperview()
        let alert = UIAlertController(title: "Ops!", message: "Ocorreu um erro ao tentar atualizar os dados. O problema pode ter sido por falta de conexao com a internet ou problemas no servidor. Tente mais tarde", preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction) -> Void in
            
            self.navigationController?.popViewControllerAnimated(true)
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }

    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat
    {
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.max))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if(self.universidade.editing)
        {
            return 1
        }
        else if(self.curso.editing)
        {
            return Cursos.cursosDisponiveis().count
        }
        else if(self.periodo.editing)
        {
            return Periodos.periodosDisponiveis().count
        }
        else
        {
            return 0
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if(self.universidade.editing)
        {
            return "PUC-Rio Gávea"
        }
        else if(self.curso.editing)
        {
            return Cursos.cursosDisponiveis()[row]
        }
        else if(self.periodo.editing)
        {
            return "\(Periodos.periodosDisponiveis()[row])"
        }
        else
        {
            return ""
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(self.universidade.editing)
        {
            self.universidade.text = "PUC-Rio Gávea"
            self.universidade.endEditing(true)
        }
        else if(self.curso.editing)
        {
            self.curso.text = Cursos.cursosDisponiveis()[row]
            self.curso.endEditing(true)
        }
        else if(self.periodo.editing)
        {
            self.periodo.text = "\(Periodos.periodosDisponiveis()[row])"
            self.periodo.endEditing(true)
        }
    }
    
    func endEditions()
    {
        self.view.endEditing(true)
    }
}
