//
//  PropertyTypeTableCellController.swift
//  Airbnb-Price-Navigator
//
//  Created by Iyin Raphael on 9/18/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit

class ProprtyTypeTableViewCell: UITableViewCell {
    
    //MARK: - Property
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        updateView()
    }
    
    let propertyTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(x: 10.0, y: 10.0, width: 221.0, height: 24.0)
        label.font.withSize(12.0)
        return label
    }()
    
    private func updateView() {
        addSubview(propertyTypeLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
