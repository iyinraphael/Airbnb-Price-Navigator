//
//  PropertyDiscovryViewCell.swift
//  Airbnb-Price-Navigator
//
//  Created by Iyin Raphael on 10/13/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit

class PropertyDiscoveryViewCell: UITableViewCell {
    
    var mageView: UIImageView!
    var label: UILabel!
    var textView: UITextView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stackview = UIStackView()
        self.addSubview(stackview)
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.spacing = 10.0
        stackview.alignment = .center
        stackview.axis = .vertical
        stackview.distribution = .fillEqually
        stackview.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0).isActive = true
        stackview.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0.0).isActive = true
        stackview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0.0).isActive = true
        stackview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.0).isActive = true
        
        let _ : UIImageView = {
            mageView = UIImageView()
            stackview.addArrangedSubview(mageView)
            return mageView
        }()
      
        let _ : UILabel = {
            label = UILabel()
            stackview.addArrangedSubview(label)
            return label
            
        }()
        
        let _: UITextView = {
            textView = UITextView()
            stackview.addArrangedSubview(textView)
            return textView
        }()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
