//
//  CellProfile_TableViewCell.swift
//  GenteBoaBeta
//
//  Created by Filipo Negrao on 17/01/16.
//  Copyright © 2016 Filipo Negrao. All rights reserved.
//

import UIKit

class CellProfile_TableViewCell: UITableViewCell
{
    
    var roundedView : UIView!
    
    var title : UILabel!
    
    var number : UILabel!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.roundedView = UIView(frame: CGRectMake(5,5,self.frame.size.width - 10, self.frame.size.height - 10))
        self.roundedView.backgroundColor = GMColor.green100Color()
        self.roundedView.layer.cornerRadius = 8
        self.addSubview(self.roundedView)
        
        self.number = UILabel(frame: CGRectMake(self.roundedView.frame.size.width - 30, 5, 30, 30))
        self.roundedView.addSubview(self.number)
        
        self.title = UILabel(frame: CGRectMake(5,5,self.roundedView.frame.size.width - 40, self.roundedView.frame.size.height - 10))
        self.roundedView.addSubview(self.title)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        
        
        
        
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
