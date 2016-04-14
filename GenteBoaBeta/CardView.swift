//
//  CardView.swift
//  GenteBoaBeta
//
//  Created by Filipo Negrao on 06/11/15.
//  Copyright © 2015 Filipo Negrao. All rights reserved.
//

import Foundation
import UIKit

class CardView : UIView, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate
{
    weak var people : People!
    
    var tableView : UITableView!
    
    //Itens do cardView
    var imageView : UIImageView!

    var nameLabel : UILabel!

    var courseLabel : UILabel!
    
    //Labels
    
    var neg : UIView!
    
    var pos: UIView!
    
    var aboutView : UITextView!

    
    init(frame: CGRect, people: People)
    {
        self.people = people
        
        super.init(frame: frame)
        
        self.clipsToBounds = true
        self.layer.borderWidth = 0.2
        self.layer.borderColor = UIColor.grayColor().CGColor
        self.layer.cornerRadius = 20
        
        self.backgroundColor = UIColor.whiteColor()
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOffset = CGSizeMake(-1, -1)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.4
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).CGPath
        
        self.tableView = UITableView(frame: self.bounds)
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.layer.cornerRadius = self.layer.cornerRadius
        self.tableView.separatorStyle = .None
        self.addSubview(self.tableView)
        
    }
    
    deinit
    {
        self.people = nil
        self.tableView.delegate = nil
        self.tableView.dataSource = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.selectionStyle = .None
        
        
        switch indexPath.row
        {
        case 0:
            
            self.imageView?.removeFromSuperview()
            self.imageView = UIImageView(frame: CGRectMake(0, 0, self.tableView.frame.size.width, cell.frame.size.height*3/4))
            self.imageView.clipsToBounds = true
            self.imageView.contentMode = .ScaleAspectFill
            self.imageView.image = self.people.photo
            cell.addSubview(self.imageView)
            
            self.nameLabel?.removeFromSuperview()
            self.nameLabel = UILabel(frame: CGRectMake(10,self.imageView.frame.origin.y + self.imageView.frame.size.height + 5, self.tableView.frame.size.width - 20, cell.frame.size.height/8))
            self.nameLabel.text = self.people.name
            self.nameLabel.textAlignment = .Left
            self.nameLabel.font = UIFont(name: "Arial Rounded MT Bold", size: 25)
            cell.addSubview(self.nameLabel)
            
            self.courseLabel?.removeFromSuperview()
            self.courseLabel = UILabel(frame: CGRectMake(10, self.nameLabel.frame.origin.y + self.nameLabel.frame.size.height, self.tableView.frame.size.width, cell.frame.size.height/8))
            self.courseLabel.font = UIFont(name: "Helvetica-Bold", size: 12)
            self.courseLabel.numberOfLines = 0
            self.courseLabel.textColor = UIColor.grayColor()
            if(self.people.course.characters.count > 26)
            {
                let curso = self.people.course.componentsSeparatedByString("(") [0]
                self.courseLabel.text = "\(self.people.period)º Período de \(curso)"
            }
            else
            {
                self.courseLabel.text = "\(self.people.period)º Período de \(self.people.course)"
            }
            cell.addSubview(self.courseLabel)
            
            return cell
            
            
        case 1:
            
            self.pos?.removeFromSuperview()
            self.pos = UIView(frame: CGRectMake(0,5,tableView.frame.size.width, self.tableView.frame.size.height/4 - 10))
            pos.backgroundColor = GMColor.green400Color()
//            pos.layer.cornerRadius = 4
            pos.layer.shadowColor = UIColor.blackColor().CGColor
            pos.layer.shadowOffset = CGSizeMake(1, 1)
            pos.layer.shadowRadius = 1
            pos.layer.shadowOpacity = 0.5
            pos.layer.masksToBounds = false
            pos.layer.shadowPath = UIBezierPath(roundedRect: pos.bounds, cornerRadius: pos.layer.cornerRadius).CGPath
            
            cell.subviews.last?.removeFromSuperview()

            cell.addSubview(pos)

            let label = UILabel(frame: CGRectMake(0,0,pos.frame.size.width/3,pos.frame.size.height))
            label.text = "Avaliações\npositivas"
            label.numberOfLines = 2
            label.font = UIFont(name: "Helvetica Bold", size: 14)
            label.textAlignment = .Center
            label.textColor = UIColor.whiteColor()
            
            while ((pos.subviews.last?.removeFromSuperview()) != nil) {}
            pos.addSubview(label)

            var text : String!
            if(self.people.positivas.count == 0)
            {
                text = "Sem feedbacks ainda!\nSeja o primeiro a avaliar!"
            }
            else
            {
                text = "\(self.people.positivas[0].name) \(self.people.positivas[0].times)\n\(self.people.positivas[1].name) \(self.people.positivas[1].times)\n\(self.people.positivas[2].name) \(self.people.positivas[2].times)"
            }

            let pontos = UILabel(frame: CGRectMake(pos.frame.size.width/3,0,pos.frame.size.width*2/3,pos.frame.size.height))
            pontos.text = text
            pontos.textColor = UIColor.whiteColor()
//            pontos.font = UIFont(name: "Helvetica", size: 12)
            pontos.numberOfLines = 3
            pos.addSubview(pontos)
            
            return cell
            
        case 2:
            
            self.neg?.removeFromSuperview()
            self.neg = UIView(frame: CGRectMake(0,5,tableView.frame.size.width, self.tableView.frame
                .size.height/4 - 10 ))
            neg.backgroundColor = GMColor.green100Color()
//            neg.layer.cornerRadius = 5
            neg.layer.shadowColor = UIColor.blackColor().CGColor
            neg.layer.shadowOffset = CGSizeMake(1, 1)
            neg.layer.shadowRadius = 1
            neg.layer.shadowOpacity = 0.5
            neg.layer.masksToBounds = false
            neg.layer.shadowPath = UIBezierPath(roundedRect: neg.bounds, cornerRadius: neg.layer.cornerRadius).CGPath
            
            cell.subviews.last?.removeFromSuperview()

            cell.addSubview(neg)

            let label = UILabel(frame: CGRectMake(0,0,neg.frame.size.width/3,neg.frame.size.height))
            label.text = "Posso\nmelhorar"
            label.numberOfLines = 2
            label.textAlignment = .Center
            label.font = UIFont(name: "Helvetica Bold", size: 14)
            label.textColor = GMColor.green600Color()
            cell.addSubview(label)

            var text : String!
            if(self.people.positivas.count == 0)
            {
                text = "Sem feedbacks ainda!\nSeja o primeiro a avaliar!"
            }
            else
            {
                text = "\(self.people.negativas[0].name) \(self.people.negativas[0].times)\n\(self.people.negativas[1].name) \(self.people.negativas[1].times)\n\(self.people.negativas[2].name) \(self.people.negativas[2].times)"
            }

            let pontos = UILabel(frame: CGRectMake(neg.frame.size.width/3,0,neg.frame.size.width*2/3,neg.frame.size.height))
            pontos.text = text
            pontos.textColor = UIColor.blackColor()
            //            pontos.font = UIFont(name: "Helvetica", size: 12)
            pontos.numberOfLines = 3
            
            while ((neg.subviews.last?.removeFromSuperview()) != nil) {}

            neg.addSubview(pontos)
            
            return cell
            
        case 3:
            
            self.aboutView?.removeFromSuperview()
            self.aboutView = UITextView(frame: CGRectMake(0,5,tableView.frame.size.width, self.tableView.frame
                .size.height/4 - 10 ))
            self.aboutView.backgroundColor = GMColor.grey300Color()
            self.aboutView.layer.cornerRadius = 5
            self.aboutView.layer.shadowColor = UIColor.blackColor().CGColor
            self.aboutView.layer.shadowOffset = CGSizeMake(-1, 1)
            self.aboutView.layer.shadowRadius = 1
            self.aboutView.layer.shadowOpacity = 0.5
            self.aboutView.layer.masksToBounds = false
            self.aboutView.layer.shadowPath = UIBezierPath(roundedRect: self.aboutView.bounds, cornerRadius: self.aboutView.layer.cornerRadius).CGPath
            self.aboutView.text = "Sobre mim: \(self.people.about)"
            self.aboutView.font = UIFont(name: "Arial Rounded MT Bold", size: 14)
            self.aboutView.textColor = UIColor.grayColor()
            self.aboutView.userInteractionEnabled = false
            
            cell.addSubview(self.aboutView)
            
            return cell
            
        default:
            
            return cell
            
        }
        
 
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        NSNotificationCenter.defaultCenter().postNotificationName("clickProfile", object: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 4
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        switch indexPath.row
        {
        case 0:
            
            return self.tableView.frame.size.height*3/4
            
        default:
            
            return self.tableView.frame.size.height/4
        }
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
    
    
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        let cell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))
        
        if(scrollView.contentOffset.y < 0)
        {
            self.imageView.alpha = 1
            self.imageView.frame.origin.y = scrollView.contentOffset.y
            self.imageView.frame.size.height = cell!.frame.size.height*3/4 - (scrollView.contentOffset.y)
        }
//        else if(scrollView.contentOffset.y <= 150 && scrollView.contentOffset.y > 0)
//        {
//            self.imageView.alpha = 1 - scrollView.contentOffset.y/150
//        }
        
    }
    
}