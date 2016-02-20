//
//  Settings_ViewController.swift
//  FFVChat
//
//  Created by Fernanda Carvalho on 17/09/15.
//  Copyright (c) 2015 FilipoNegrao. All rights reserved.
//

import UIKit
import Foundation

class Settings_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    var tableView : UITableView!
    
    let section1 = ["Sonbre nós", "Termos de uso"]
    
    let section2 = ["Logout"]
    
    var closeButton : UIBarButtonItem!
    
    var imageView : UIImageView!
    
    var imagePicker : UIImagePickerController!
    
    var loadingView : LoadingView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.title = DAOUser.sharedInstance.getUsername()

        
        self.view.backgroundColor = GMColor.grey200Color()
        
        self.tableView = UITableView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .None
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        self.view.addSubview(self.tableView)
        
        self.closeButton = UIBarButtonItem(image: UIImage(named: "close"), style: .Bordered, target: self, action: "back")
        self.navigationItem.leftBarButtonItem = self.closeButton
        
        self.imageView = UIImageView(frame: CGRectMake(0, 0, screenWidth, screenWidth))

        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool)
    {
        
//        self.navigationController?.navigationBar.hidden = false
//        let bar : UINavigationBar! =  self.navigationController?.navigationBar
//    
//        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.blackColor()]
//        bar.titleTextAttributes = titleDict as? [String : AnyObject]
//        self.title = "Settings"
//        
//        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(hex: 0xaa1d1d)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //****************************************************//
    //*********** TABLE VIEW PROPERTIES ******************//
    //****************************************************//
    
    //Espaçamento em baixo
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 0
    }
    
    //Espaçamento em cima
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if(section == 0) { return 0 }
        else
        {
            return 50
        }
    }
    
    //View transparente do espaçamento de baixo
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        return nil
    }
    
    //View transparente do espaçamento de cima
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let view = UIView(frame: CGRectMake(0,0,screenWidth, 50))
        view.backgroundColor = UIColor.clearColor()
        
        let name = UILabel(frame: CGRectMake(10,0,screenWidth, 50))
        name.textColor = UIColor.grayColor()
        view.addSubview(name)
        
        switch section
        {
        case 0:
            
            return nil
            
        case 1:
            
            name.text = "Informações"
            
        case 2:
            
            name.text = "Conta"
            
        default:
            
            name.text = ""
        }
        
        return view
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(section == 0)
        {
            return 2
        }
        else if(section == 1)
        {
            return 2
        }
        else if(section == 2)
        {
            return 1
        }

        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        
        switch indexPath.section
        {
        case 0:
            
            switch indexPath.row
            {
            case 0:
                
                return screenWidth*2/3
                
            case 1:
                
                return 55
                
            default:
                
                return 55
            }
            
        default:
            
            return 55
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.selectionStyle = .Default
        cell.backgroundColor = UIColor.whiteColor()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        
        switch indexPath.section
        {
        //SECAO DA FOTO E EDITAR PEFIL
        case 0:
            
            switch indexPath.row
            {
            //FOTO
            case 0:
                
                self.imageView = UIImageView(frame: CGRectMake(0, 0, cell.frame.size.height - 10, cell.frame.size.height - 10))
                self.imageView.center = cell.center
                self.imageView.contentMode = .ScaleAspectFill
                self.imageView.image = DAOUser.sharedInstance.getProfileImage()
                self.imageView.clipsToBounds = true
                self.imageView.layer.cornerRadius = self.imageView.frame.size.width/2
                self.imageView.layer.borderColor = UIColor.whiteColor().CGColor
                self.imageView.layer.borderWidth = 4
                while(cell.subviews.last?.removeFromSuperview() != nil) {}
                
                cell.backgroundColor = GMColor.grey200Color()
                cell.addSubview(self.imageView)
                
            //EDITAR CONFIG.
            case 1:
                
                cell.textLabel?.text = "Editar meu perfil"
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                
            default:
                cell.accessoryType = UITableViewCellAccessoryType.None

            }
        
        //SOBRE
        case 1:
            
            switch indexPath.row
            {
            //Termos de privacidade
            case 0:
                
                cell.textLabel?.text = "Termos de Uso"
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator

            case 1:
                
                cell.textLabel?.text = "Sobre nós"
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                
            default:
                cell.accessoryType = UITableViewCellAccessoryType.None

                
            }
         
        //CONTA
        case 2:
            
            cell.textLabel?.text = "Sair"
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator

            
        default:
            cell.accessoryType = UITableViewCellAccessoryType.None
            
        }
        
        return cell
    }
    
    func scrollViewDidScrollToTop(scrollView: UIScrollView)
    {
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        switch indexPath.section
        {
        case 0:
            
            if(indexPath.row == 0)
            {
                self.changeProfilePicture()
            }
            else
            {
                let edit = EditPerfil_ViewController()
                self.navigationController?.pushViewController(edit, animated: true)
            }
            
        case 1:
            
            switch indexPath.row
            {
            case 0:
                
                self.navigationController?.pushViewController(PrivacyViewController(), animated: true)
                
            case 1:
                
                self.navigationController?.pushViewController(AboutViewController(), animated: true)
                
            default: break
            }
            
        case 2:
            
            let alert = UIAlertController(title: "Tem certeza?", message: "Tem certeza que deseja deslogar com sua conta do aplicativo?", preferredStyle: .Alert)
            
            alert.addAction(UIAlertAction(title: "Sim", style: .Default, handler: { (action: UIAlertAction) -> Void in
                self.logOut()
            }))
            
            alert.addAction(UIAlertAction(title: "Nao", style: .Cancel, handler: { (action: UIAlertAction) -> Void in
                
                
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
        default: break
            
        }
    }
    
    func tableViewScrollToBottom(animated: Bool) {
        
        let delay = 0.0 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(time, dispatch_get_main_queue(), {
            
            let numberOfSections = self.tableView.numberOfSections
            let numberOfRows = self.tableView.numberOfRowsInSection(numberOfSections-1)
            
            if numberOfRows > 0 {
                let indexPath = NSIndexPath(forRow: numberOfRows-1, inSection: (numberOfSections-1))
                self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: animated)
            }
            
        })
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
//        if(scrollView.contentOffset.y < 0)
//        {
//            self.imageView.frame.origin.y = scrollView.contentOffset.y
//            self.imageView.frame.size.height = screenWidth*2/3 - (scrollView.contentOffset.y)
//        }
        
    }
    
    //****************************************************//
    //*********** END TABLE VIEW PROPERTIES **************//
    //****************************************************//
    
    
    //Functions
    
    func changeProfilePicture()
    {
        let alert = UIAlertController(title: "Select a photo", message: "Choose the source", preferredStyle: UIAlertControllerStyle.ActionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction) -> Void in
            
            self.imagePicker = UIImagePickerController()
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = .Camera
            self.imagePicker.cameraDevice = .Front
            self.imagePicker.allowsEditing = true
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
        
            
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .Default, handler: { (action: UIAlertAction) -> Void in
            
            self.imagePicker = UIImagePickerController()
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = .PhotoLibrary
            self.imagePicker.allowsEditing = true
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
            
            
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel, handler: { (action: UIAlertAction) -> Void in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        self.imagePicker.dismissViewControllerAnimated(true, completion: nil)
        self.loadingView = LoadingView()
        self.navigationController?.view.addSubview(self.loadingView)
        
        DAOUser.sharedInstance.changeProfilePicture(image) { (success) -> Void in
            
            if(success)
            {
                self.imageView.image = image
                self.loadingView?.removeFromSuperview()
            }
            else
            {
                let alert = UIAlertController(title: "Opd!", message: "Ocorreu um erro ao tentar salvar a nova image de perfil. O erro pode ter sido causado pela falta de internet ou por problemas no servidor. Tente mais tarde", preferredStyle: .Alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction) -> Void in
                    
                }))
                
                self.presentViewController(alert, animated: true, completion: nil)
            }
            
        }
        
    }
    
    func aboutUs()
    {
        
    }
    
    func privacyAndUse()
    {
        
    }
    
    func changePassword()
    {
        
    }
    
    func cleanData()
    {
        
    }
    
    func logOut()
    {
        print("saindo..")
        DAOUser.sharedInstance.logout { (error) -> Void in
            
            if(error == nil)
            {
                let window = ((UIApplication.sharedApplication().delegate) as! AppDelegate).window
                window?.rootViewController = Login_ViewController()
                window?.makeKeyAndVisible()
            }
            
        }
        
    }
    
    func back()
    {
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    

}
