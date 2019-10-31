//
//  PropertyTeamViewCell.swift
//  Airbnb-Price-Navigator
//
//  Created by Iyin Raphael on 10/30/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit

class PropertyTeamViewCell: UITableViewCell {
    
    var cellImageView: UIImageView!
    var label: UILabel!
    var textView: UITextView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stackview = UIStackView()
        self.isUserInteractionEnabled = false
        self.addSubview(stackview)
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.alignment = .center
        stackview.spacing = 5.0
        stackview.axis = .vertical
        stackview.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0).isActive = true
        stackview.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0.0).isActive = true
        stackview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0.0).isActive = true
        stackview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.0).isActive = true
        
        let _ : UIImageView = {
            cellImageView = UIImageView()
            stackview.addArrangedSubview(cellImageView)
            cellImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            cellImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
            cellImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            cellImageView.clipsToBounds = true
            let radius = cellImageView.frame.width / 2
            cellImageView.layer.cornerRadius = radius
            return cellImageView
           }()
        
        let _ : UILabel = {
            label = UILabel()
            stackview.addArrangedSubview(label)
            return label
        }()
        
        let _ : UITextView = {
            textView = UITextView()
            stackview.addArrangedSubview(textView)
            textView.textAlignment = .center
            textView.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
            textView.widthAnchor.constraint(equalToConstant: 250.0).isActive = true
            return textView
        }()
           
        
    }
    
  
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
