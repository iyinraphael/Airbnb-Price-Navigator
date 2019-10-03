//
//  PropertyTypeTableViewController.swift
//  Airbnb-Price-Navigator
//
//  Created by Iyin Raphael on 9/17/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class PropertyTypeTableViewController: UIViewController {
    
    //MARK: - Property
    var tableView: UITableView!
    var propertyTypeArray = [String]()
    
    //MARK: - Set up
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.frame = CGRect(x: 0.0, y: 0.0, width: 291, height: 295)
    
        let tableView = UITableView(frame: CGRect.zero)
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0).isActive = true
        tableView.register(PropertyTypeTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        self.tableView = tableView
        
        propertyTypeArray += ["House", "Apartment", "Condominium", "Townhouse", "Loft", "Guest Suite", "Bungalow", "Villa", "other"]
    }
    
}


extension PropertyTypeTableViewController: UITableViewDataSource, UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! PropertyTypeTableViewCell
        cell.propertyTypeLabel.text = propertyTypeArray[indexPath.row]
        return cell
    }
    
}
