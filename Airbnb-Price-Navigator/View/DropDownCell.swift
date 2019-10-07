//
//  DropDownCell.swift
//  Airbnb-Price-Navigator
//
//  Created by Iyin Raphael on 9/27/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit

class DropDownCell: UITableViewCell {
    
    var cellFont: UIFont = UIFont.systemFont(ofSize: 18, weight: .semibold)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(with title: String) {
        self.selectionStyle = .none
        self.textLabel?.font = cellFont
        self.backgroundColor = UIColor.clear
        self.textLabel?.text = title
    }
}
