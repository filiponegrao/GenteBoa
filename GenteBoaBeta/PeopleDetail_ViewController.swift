//
//  PeopleDetail_ViewController.swift
//  GenteBoaBeta
//
//  Created by Filipo Negrao on 17/01/16.
//  Copyright © 2016 Filipo Negrao. All rights reserved.
//

import UIKit

class PeopleDetail_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate
{
    var people : People!
    
    var scrollView : UIScrollView!
    
    var imageView : UIImageView!
    
    var nameLabel : UILabel!
    
    var courseLabel : UILabel!
    
    var positivasLabel : UILabel!
    
    var negativasLabel : UILabel!
    
    var tableView1 : UITableView!
    
    var tableView2 : UITableView!
    
    let cellHeight : CGFloat = 40
    
    let margem : CGFloat = 20
    
    var textView : UITextView!
    
    var moreLabel : UILabel!
    
    init(people: People)
    {
        self.people = people
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.title = "Perfil completo"
        
        self.scrollView = UIScrollView(frame: CGRectMake(0, 50, screenWidth, screenHeight))
        self.scrollView.backgroundColor = UIColor.whiteColor()
        self.scrollView.delegate = self
        self.view.addSubview(self.scrollView)
        
        self.imageView = UIImageView(frame: CGRectMake(0, 0, screenWidth, screenWidth*2/3))
        self.imageView.contentMode = .ScaleAspectFill
        self.imageView.clipsToBounds = true
        self.imageView.image = self.people.photo
        self.scrollView.addSubview(self.imageView)
        
        self.nameLabel = UILabel(frame: CGRectMake(10,self.imageView.frame.origin.y + self.imageView.frame.size.height, screenWidth - 20, 40))
        self.nameLabel.text = self.people.name
        self.nameLabel.font = UIFont(name: "Arial Rounded MT Bold", size: 25)
        self.scrollView.addSubview(self.nameLabel)
        
        self.courseLabel = UILabel(frame: CGRectMake(10, self.nameLabel.frame.origin.y + self.nameLabel.frame.size.height, screenWidth - 20, 40))
        self.courseLabel.text = "\(self.people.period)º Período de \(self.people.course) na \(self.people.university)"
        self.courseLabel.adjustsFontSizeToFitWidth = true
        self.courseLabel.minimumScaleFactor = 0.1
        self.courseLabel.numberOfLines = 2
        self.courseLabel.textColor = UIColor.grayColor()
        self.scrollView.addSubview(self.courseLabel)
        
        self.positivasLabel = UILabel(frame: CGRectMake(10, self.courseLabel.frame.origin.y + self.courseLabel.frame.size.height + self.margem, screenWidth - 20, 50))
        self.positivasLabel.layer.cornerRadius = 8
        self.positivasLabel.backgroundColor = GMColor.green400Color()
        self.positivasLabel.text = "Avaliações positivas"
        self.positivasLabel.textAlignment = .Center
        self.positivasLabel.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
        self.positivasLabel.textColor = UIColor.whiteColor()
        self.positivasLabel.clipsToBounds = true
        self.scrollView.addSubview(self.positivasLabel)
        
        self.tableView1 = UITableView(frame: CGRectMake(0, self.positivasLabel.frame.origin.y + self.positivasLabel.frame.size.height, screenWidth, CGFloat(self.people.positivas.count) * self.cellHeight))
        self.tableView1.delegate = self
        self.tableView1.dataSource = self
        self.tableView1.registerClass(CellProfile_TableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView1.scrollEnabled = false
        self.scrollView.addSubview(self.tableView1)
        
        self.negativasLabel = UILabel(frame: CGRectMake(10, self.tableView1.frame.origin.y + self.tableView1.frame.size.height + self.margem, screenWidth - 20, 50))
        self.negativasLabel.layer.cornerRadius = 8
        self.negativasLabel.backgroundColor = GMColor.red400Color()
        self.negativasLabel.text = "Posso melhorar"
        self.negativasLabel.textAlignment = .Center
        self.negativasLabel.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
        self.negativasLabel.textColor = UIColor.whiteColor()
        self.negativasLabel.clipsToBounds = true
        self.scrollView.addSubview(self.negativasLabel)
        
        self.tableView2 = UITableView(frame: CGRectMake(0, self.negativasLabel.frame.origin.y + self.negativasLabel.frame.size.height, screenWidth, CGFloat(self.people.negativas.count) * self.cellHeight))
        self.tableView2.delegate = self
        self.tableView2.dataSource = self
        self.tableView2.registerClass(CellProfile_TableViewCell.self, forCellReuseIdentifier: "Cell2")
        self.tableView2.scrollEnabled = false
        self.scrollView.addSubview(self.tableView2)
        
        
        self.moreLabel = UILabel(frame: CGRectMake(10, self.tableView2.frame.origin.y + self.tableView2.frame.size.height + self.margem, screenWidth - 20, 40))
        self.moreLabel.text = "Mais sobre \(self.people.name)"
        self.moreLabel.font = UIFont(name: "Arial Rounded MT Bold", size: 22)
        self.scrollView.addSubview(self.moreLabel)

        let h = self.heightForView(self.people.about, font: UIFont(name: "Helvetica", size: 14)!, width: screenWidth - 20) + 20
        
        self.textView = UITextView(frame: CGRectMake(10, self.moreLabel.frame.origin.y + self.moreLabel.frame.size.height, screenWidth - 20, h))
        self.textView.text = self.people.about
        self.textView.userInteractionEnabled = false
        self.textView.backgroundColor = GMColor.grey200Color()
        self.textView.layer.cornerRadius = 8
        self.textView.clipsToBounds = true
        self.textView.font = UIFont(name: "Helvetica", size: 14)
        self.scrollView.addSubview(self.textView)
        
        self.scrollView.contentSize = CGSizeMake(screenWidth, self.imageView.frame.size.height + self.nameLabel.frame.size.height + self.courseLabel.frame.size.height + self.positivasLabel.frame.size.height + self.tableView1.frame.size.height + self.margem*4 + self.tableView2.frame.size.height + self.negativasLabel.frame.size.height + self.moreLabel.frame.size.height + self.textView.frame.size.height + 50)

        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(tableView == self.tableView1)
        {
            return self.people.positivas.count
        }
        else if(tableView == self.tableView2)
        {
            return self.people.negativas.count
        }
        else
        {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return self.cellHeight
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if(tableView == self.tableView1)
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CellProfile_TableViewCell
            cell.selectionStyle = .None
            
            cell.roundedView.backgroundColor = GMColor.grey300Color()
            cell.title.text = self.people.positivas[indexPath.row].name
            cell.number.text = "\(self.people.positivas[indexPath.row].times)"
            
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell2", forIndexPath: indexPath) as! CellProfile_TableViewCell
            cell.selectionStyle = .None

            cell.roundedView.backgroundColor = GMColor.grey300Color()
            cell.title.text = self.people.negativas[indexPath.row].name
            cell.number.text = "\(self.people.negativas[indexPath.row].times)"
            
            return cell
        }
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        if(scrollView.contentOffset.y < 0)
        {
            self.imageView.alpha = 1
            self.imageView.frame.origin.y = scrollView.contentOffset.y
            self.imageView.frame.size.height = screenWidth*2/3 - (scrollView.contentOffset.y)
        }
//        else if(scrollView.contentOffset.y <= 100 && scrollView.contentOffset.y > 0)
//        {
//            self.imageView.alpha = 1 - scrollView.contentOffset.y/200
//        }
        
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


}
