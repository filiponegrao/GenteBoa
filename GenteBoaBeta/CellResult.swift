//
//  CellResult.swift
//  GenteBoaBeta
//
//  Created by Filipo Negrao on 15/11/15.
//  Copyright © 2015 Filipo Negrao. All rights reserved.
//

import Foundation
import UIKit

class CellResult : UITableViewCell
{
    var imageview : UIImageView!
    
    var name : UILabel!
    
    var details : UILabel!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.imageview = UIImageView(frame: CGRectMake(10, 10, self.frame.size.height, self.frame.size.height))
        self.imageview.clipsToBounds = true
        self.imageview.layer.cornerRadius = 5
        
        self.addSubview(self.imageview)
        
        self.name = UILabel(frame: CGRectMake(self.imageview.frame.origin.x + self.imageview.frame.size.width + 10, 10, screenWidth - (self.imageview.frame.origin.x + self.imageview.frame.size.width), self.frame.size.height/2))
        self.name.font = UIFont(name: "Helvetica Bold", size: 18)
        self.name.textColor = UIColor.grayColor()
        self.addSubview(self.name)
        
        self.details = UILabel(frame: CGRectMake(self.name.frame.origin.x, self.name.frame.origin.y + self.name.frame.size.height, self.name.frame.size.width, self.frame.size.height/2))
        self.details.font = UIFont(name: "Helvetica", size: 11)
        self.details.textColor = GMColor.blue400Color()
        self.addSubview(self.details)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}