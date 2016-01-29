//
//  FeedBack_ViewController.swift
//  GenteBoaBeta
//
//  Created by Filipo Negrao on 09/11/15.
//  Copyright © 2015 Filipo Negrao. All rights reserved.
//

import UIKit

class FeedBack_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var people : People!
    
    var profileImage : UIImage!
    
    var positiveView : UIView!
    
    var negativeView : UIView!
    
    var positives = [String]()
    
    var negatives = [String]()
    
    var tableView1 : UITableView!
    
    var tableView2 : UITableView!
    
    var texto1 : UILabel!
    
    var texto2 : UILabel!
    
    var imageView1 : UIImageView!
    
    var imageView2 : UIImageView!
    
    var hashtags = Hashtag.hashtagsDisponiveis()
    
    var button : UIButton!
    
    var cancelar : UIButton!
    
    var positiveComplete : Bool = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()

        //View1
        self.positiveView = UIView(frame: CGRectMake(0,0,screenWidth,screenHeight - 50))
        self.positiveView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.positiveView)
        
        self.imageView1 = UIImageView(frame: CGRectMake(10, 80, screenWidth/3, screenWidth/3))
        self.imageView1.image = self.profileImage
        self.imageView1.layer.cornerRadius = self.imageView1.frame.size.width/2
        self.imageView1.clipsToBounds = true
        self.imageView1.layer.borderWidth = 1
        self.positiveView.addSubview(self.imageView1)
        
        self.texto1 = UILabel(frame: CGRectMake(self.imageView1.frame.origin.x + self.imageView1.frame.size.width + 20, self.imageView1.frame.origin.y - 20, screenWidth - self.imageView1.frame.size.width - 10, screenHeight/4))
        self.texto1.text = "Escolha tres pontos positivos meus ao trabalhar em grupo"
        self.texto1.numberOfLines = 4
        self.positiveView.addSubview(self.texto1)
        
        self.tableView1 = UITableView(frame: CGRectMake(0, self.imageView1.frame.origin.y + self.imageView1.frame.size.height + 10, screenWidth, screenHeight*2/3 - 50))
        self.tableView1.delegate = self
        self.tableView1.dataSource = self
        self.tableView1.backgroundColor = GMColor.green300Color()
        self.tableView1.registerClass(CellFeedback.self, forCellReuseIdentifier: "Cell1")
        self.positiveView.addSubview(self.tableView1)
        
        
        //View2
        self.negativeView = UIView(frame: CGRectMake(screenWidth,0,screenWidth,screenHeight))
        self.negativeView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.negativeView)
        
        self.imageView2 = UIImageView(frame: CGRectMake(10, 80, screenWidth/3, screenWidth/3))
        self.imageView2.image = self.profileImage
        self.imageView2.layer.cornerRadius = self.imageView2.frame.size.width/2
        self.imageView2.clipsToBounds = true
        self.negativeView.addSubview(self.imageView2)
        
        self.texto2 = UILabel(frame: CGRectMake(self.imageView2.frame.origin.x + self.imageView2.frame.size.width + 20, self.imageView2.frame.origin.y - 20, screenWidth - self.imageView2.frame.size.width - 10, screenHeight/4))
        self.texto2.text = "Escolha tres pontos negativos meus ao trabalhar em grupo"
        self.texto2.numberOfLines = 4
        self.negativeView.addSubview(self.texto2)
        
        self.tableView2 = UITableView(frame: CGRectMake(0, self.imageView2.frame.origin.y + self.imageView2.frame.size.height + 10, screenWidth, screenHeight*2/3 - 50))
        self.tableView2.delegate = self
        self.tableView2.dataSource = self
        self.tableView2.backgroundColor = GMColor.red300Color()
        self.tableView2.registerClass(CellFeedback.self, forCellReuseIdentifier: "Cell2")
        self.negativeView.addSubview(self.tableView2)
        
        
        
        self.button = UIButton(frame: CGRectMake(0,screenHeight - 50, screenWidth, 50))
        self.button.backgroundColor = GMColor.orange300Color()
        self.button.enabled = false
        self.button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.button.setTitleColor(UIColor.grayColor(), forState: .Disabled)
        self.button.setTitle("Confirmar", forState: .Normal)
        self.button.setTitle("Complete", forState: UIControlState.Disabled)
        self.button.addTarget(self, action: "confirmar", forControlEvents: .TouchUpInside)
        self.button.titleLabel?.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        self.view.addSubview(self.button)
        
        self.cancelar = UIButton(frame: CGRectMake(20,20,screenWidth, 44))
//        self.cancelar.center = CGPointMake(screenWidth/2, 40)
        self.cancelar.titleLabel?.textAlignment = .Left
        self.cancelar.setTitle("Cancelar", forState: .Normal)
        self.cancelar.addTarget(self, action: "cancel", forControlEvents: .TouchUpInside)
        self.cancelar.setTitleColor(GMColor.orange300Color(), forState: .Normal)
        self.view.addSubview(self.cancelar)
        
        self.view.addSubview(AtencaoView(controller: self))
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        removePartialCurlTap()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell : CellFeedback!
        
        if(tableView == tableView1)
        {
            cell = tableView.dequeueReusableCellWithIdentifier("Cell1", forIndexPath: indexPath) as! CellFeedback
        }
        else
        {
            cell = tableView.dequeueReusableCellWithIdentifier("Cell2", forIndexPath: indexPath) as! CellFeedback
        }
        
        cell.selectionStyle = .None
        cell.backgroundColor = UIColor.clearColor()
        cell.name.text = " # " + self.hashtags[indexPath.row]
        
        if(tableView == tableView1)
        {
            let index = positives.indexOf(self.hashtags[indexPath.row])
            if(index == nil) { cell.checked = false }
            else { cell.checked = true }
            cell.refreshStatus()
        }
        else
        {
            let index = negatives.indexOf(self.hashtags[indexPath.row])
            if(index == nil) { cell.checked = false }
            else { cell.checked = true}
            cell.refreshStatus()
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let cell  = tableView.cellForRowAtIndexPath(indexPath) as! CellFeedback
        
        if(tableView == tableView1)
        {
            let index = self.positives.indexOf(self.hashtags[indexPath.row])
            if (index == nil)
            {
                if(self.positives.count == 3)
                {
                    let alert = UIAlertController(title: "Ops!", message: "São apenas 3 pontos!", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction) -> Void in
                        
                    }))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                else
                {
                    self.positives.append(self.hashtags[indexPath.row])
                    cell.checked = true
                    cell.refreshStatus()
                }
            }
            else
            {
                self.positives.removeAtIndex(index!)
                cell.checked = false
                cell.refreshStatus()
            }
        }
        else
        {
            let index = self.negatives.indexOf(self.hashtags[indexPath.row])
            if (index == nil)
            {
                if(self.negatives.count == 3)
                {
                    let alert = UIAlertController(title: "Ops!", message: "São apenas 3 pontos!", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction) -> Void in
                        
                    }))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                else
                {
                    self.negatives.append(self.hashtags[indexPath.row])
                    cell.checked = true
                    cell.refreshStatus()
                }
            }
            else
            {
                self.negatives.removeAtIndex(index!)
                cell.checked = false
                cell.refreshStatus()
            }
        }

        self.checkEnabled()
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.hashtags.count
    }

    
    
    func checkEnabled()
    {
        if(!self.positiveComplete)
        {
            if(self.positives.count >= 3)
            {
                self.button.enabled = true
            }
            else
            {
                self.button.enabled = false
            }
        }
        else
        {
            if(self.negatives.count >= 3)
            {
                self.button.enabled = true
            }
            else
            {
                self.button.enabled = false
            }
        }
    }
    
    
    private func removePartialCurlTap() {
        if let gestures = self.view.gestureRecognizers {
            for gesture in gestures {
                self.view.removeGestureRecognizer(gesture)
            }
        }
    }

    
    func confirmar()
    {
        if(self.positiveComplete == false)
        {
            UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 10, initialSpringVelocity: 5, options: .CurveEaseOut, animations: { () -> Void in
                
                self.positiveView.frame.origin.x = -screenWidth
                self.negativeView.frame.origin.x = 0
                
                }) { (succes: Bool) -> Void in
                    
                    self.positiveComplete = true
                    self.button.enabled = false
            }
        }
        else
        {
            DAOPeople.sharedInstance.giveSomeoneFeedback(self.people.email, positive: self.positives, negative: self.negatives)
            self.view.addSubview(DoneView(controller: self))
        }
    }
    
    func cancel()
    {
        let alert = UIAlertController(title: "Tem certeza?", message: "Tem certeza que deseja cancelar seu feedback?", preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "Sim", style: .Default, handler: { (action: UIAlertAction) -> Void in
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                
            })
        }))
        
        alert.addAction(UIAlertAction(title: "Não", style: .Cancel, handler: { (action2: UIAlertAction) -> Void in
            
        }))
        
        self.presentViewController(alert, animated: true) { () -> Void in
            
        }
    }
    
}
