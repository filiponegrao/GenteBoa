//
//  PopOverMenu_ViewController.swift
//  GenteBoaBeta
//
//  Created by Filipo Negrao on 16/01/16.
//  Copyright © 2016 Filipo Negrao. All rights reserved.
//

import UIKit

class PopOverMenu_ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    var presnetingController : UIViewController!
    
    var tableView : UITableView!
    
    var options = ["Filtrar por curso:", "Buscar usuário"]

    init(presentingController: UIViewController)
    {
        self.presnetingController = presentingController
        super.init(nibName: nil, bundle: nil)
    }

    override func viewWillDisappear(animated: Bool)
    {
        self.unBlur()        
    }
    
    func unBlur()
    {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            (self.presnetingController as! Home_ViewController).blurView.alpha = 0
            
            
            }) { (success: Bool) -> Void in
                
                (self.presnetingController as! Home_ViewController).blurView.removeFromSuperview()
                
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()

        self.tableView = UITableView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.scrollEnabled = false
        self.view.addSubview(self.tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.options.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.backgroundColor = UIColor.clearColor()
        
        if(indexPath.row == 0)
        {
            cell.accessoryType = UITableViewCellAccessoryType.None
            cell.textLabel?.text = "\(self.options[indexPath.row]) \(DAOPeople.sharedInstance.getCurrentFilter())"
        }
        else
        {
            cell.textLabel?.text = self.options[indexPath.row]
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        
//        cell.textLabel?.font = UIFont(name: "Arial Rounded MT Bold", size: 14)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if(indexPath.row == 1)
        {
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                let search = Search_ViewController()
                (self.presnetingController as! Home_ViewController).closeFilter()
                (self.presnetingController as! Home_ViewController).navigationController!.pushViewController(search, animated: true)
            })
        }
        else
        {
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                
                (self.presnetingController as! Home_ViewController).openFilter()
            })
        }
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return self.view.frame.size.height/2
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
