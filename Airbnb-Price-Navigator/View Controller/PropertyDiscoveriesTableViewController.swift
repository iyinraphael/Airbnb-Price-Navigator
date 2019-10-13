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
    let text = ["""
                While it may be intuitive that having high review score ratings can increase your daily listing price, having at least 60 reviews will get you, on average, an increase in listing price of 20% as compared to people who have received 20 to 60 reviews.
                """,
                
                """
                There is an option on Airbnb that enables for a home to be instantly bookable;
                interestingly enough we’ve found that on average,
                homes that are instantly bookable will have a lower listing price.
                """,
                
                """
                Did you know amenities are a necessary part of any valuable Airbnb listing? We've found that, on average, homes that have more than 85 amenities list for an additional 100% price increase than homes with 28 or fewer amenities. Essential ammenities include towels, toilet paper, soap, pillows, and bed linings.
                """,
                
                """
                Did you know bed types can have a notable influence on your daily listing price? We’ve found that, on average, real beds go for an 80% price increase as compared to airbeds.
                """,
                
                """
                It is important to build an image of trust with your customers; don’t forget to upload a profile picture with your listing. Listings whose owners have profile pictures have daily listing prices of 30% greater than listings with no accompanying profile picture.
                """,
                
                """
                Also, don’t forget to add your identity! Users who have their identity verified will see a 5% increase in their listing prices.
                """]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView()
        tableView.dataSource = self
        tableView.separatorStyle = .none
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
        let cellText = text[indexPath.row]
        cell.mageView.image = UIImage(named: discoveryImage)
        cell.label.text = textTitle
        cell.textView.text = cellText
        return cell
    }
    
    
    
}
