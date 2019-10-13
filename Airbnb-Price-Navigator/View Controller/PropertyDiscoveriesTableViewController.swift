//
//  PropertyDiscoveriesTableViewController.swift
//  Airbnb-Price-Navigator
//
//  Created by Iyin Raphael on 10/13/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit

class PropertyDiscoveriesTableViewController: PropertyBaseNavViewController {
    
    var tableView: UITableView!
    let reuseIdentifier = "cell"
    let images = ["badge", "house", "toilet", "bed", "placeholder", "employee"]
    let labels = ["Reviews", "Instantly Bookable", "Amenities", "Bed Types", "Build Trust", "Identity"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView()
        tableView.dataSource = self
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
        tableView.register(PropertyDiscoveryViewCell.self, forCellReuseIdentifier: reuseIdentifier)

    }
    
}

extension PropertyDiscoveriesTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? PropertyDiscoveryViewCell else { return UITableViewCell()}
        let discoveryImage = images[indexPath.row]
        let textTitle = labels[indexPath.row]
        cell.mageView.image = UIImage(named: discoveryImage)
        cell.label.text = textTitle
        return cell
    }
    
    
    
}
