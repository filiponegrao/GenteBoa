//
//  Search_ViewController.swift
//  GenteBoa
//
//  Created by Filipo Negrao on 02/11/15.
//  Copyright © 2015 Filipo Negrao. All rights reserved.
//

import UIKit

class Search_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate, UIScrollViewDelegate
{

    var searchBar : UISearchBar!
    
    var tableView : UITableView!
    
    var result = [MetaPeople]()
    
    var tableViewHeight : CGFloat!
    
    var loadingScreen : LoadingView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.title = "Busca"
        
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(hex: 0xaa1d1d)
        
        self.searchBar = UISearchBar(frame: CGRectMake(20,70,screenWidth - 40,44))
        self.searchBar.placeholder = "Busque um usuario"
        self.searchBar.delegate = self
        self.searchBar.barTintColor = UIColor.whiteColor()
        self.searchBar.searchBarStyle = .Minimal
        self.view.addSubview(self.searchBar)
        
        self.tableViewHeight = screenHeight - self.searchBar.frame.size.height - (self.navigationController?.navigationBar.frame.size.height)!
        
        self.tableView = UITableView(frame: CGRectMake(0, self.searchBar.frame.origin.y + self.searchBar.frame.size.height, screenWidth, self.tableViewHeight))
        self.tableView.registerClass(CellResult.self, forCellReuseIdentifier: "Cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = UIColor.clearColor()
        self.view.addSubview(self.tableView)

    }
    
    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(animated: Bool)
    {
        self.searchBar.becomeFirstResponder()
    }

    func refresh()
    {
        
    }
    
    //Sobe a view e desce a view
    func keyboardWillShow(notification: NSNotification)
    {
        if(self.view.frame.origin.y == 0)
        {
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                self.tableView.frame.size.height = -keyboardSize.height
                self.tableView.frame.origin.y = self.searchBar.frame.origin.y + self.searchBar.frame.size.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification)
    {
        UIView.animateWithDuration(0.3) { () -> Void in
            self.tableView.frame.size.height = self.tableViewHeight
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CellResult
        let name = self.result[indexPath.row].name
        
        
        cell.name.text = name
        cell.imageview.image = self.result[indexPath.row].photo
        
        var curso: String!
        if(self.result[indexPath.row].course.characters.count > 26)
        {
            curso = self.result[indexPath.row].course.componentsSeparatedByString("(") [0]
            curso = "\(curso) na \(self.result[indexPath.row].university)"
        }
        else
        {
            curso = "\(self.result[indexPath.row].course) na \(self.result[indexPath.row].university)"
        }
        
        cell.details.text = curso
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.loadingScreen = LoadingView()
        self.view.addSubview(self.loadingScreen)
        
        DAOPeople.sharedInstance.getPeople(self.result[indexPath.row].email) { (people) -> Void in
            
            if(people == nil)
            {
                let alert = UIAlertController(title: "Ops!", message: "Ocorreu um erro nos servidores! O mesmo pode ter sido causado pela falta de internet do dispositivo atual ou problemas internos com nossos servidores. Tente novamente mais tarde! :)", preferredStyle: .Alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: { (action: UIAlertAction) -> Void in
                    
                    
                }))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else
            {
                self.loadingScreen?.removeFromSuperview()
                let people = PeopleDetail_ViewController(people: people!)
                self.navigationController?.pushViewController(people, animated: true)
            }
            
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 70
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.result.count
    }
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String)
    {

    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        if(searchBar.text?.characters.count > 0)
        {
            self.searchBar.endEditing(true)
            DAOParse.sharedInstance.getUsersWithString(searchBar.text!, callback: { (results) -> Void in
                print("\(results.count) Usuarios retornados para o controller")
                self.result = results
                self.tableView.reloadData()
            })
        }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar)
    {
        self.searchBar.endEditing(true)
    }
    
    
    

}
