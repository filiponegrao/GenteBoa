//
//  CellFeedback.swift
//  GenteBoaBeta
//
//  Created by Filipo Negrao on 14/11/15.
//  Copyright © 2015 Filipo Negrao. All rights reserved.
//

import Foundation
import UIKit


class CellFeedback : UITableViewCell
{
    var checked : Bool = false
    
    var name : UILabel!
    
    var checkField : UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.checkField = UIImageView(frame: CGRectMake(screenWidth - 50, 10, 40, 40))
        self.checkField.image = UIImage(named: "checkOff")
        self.addSubview(self.checkField)
        
        self.name = UILabel(frame: CGRectMake(10,10,screenWidth - 50,30))
        self.name.text = "Hashtag selecionada"
//        self.name.font = UIFont(name: "Arial Rounded MT Bold", size: 14)
        self.addSubview(self.name)
        
        self.refreshStatus()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func refreshStatus()
    {
        if(self.checked)
        {
            self.checkField.image = UIImage(named: "checkOn")
        }
        else
        {
            self.checkField.image = UIImage(named: "checkOff")
        }
    }
   
    func changeStatus()
    {
        self.checked = !self.checked
        self.refreshStatus()
    }
    
}