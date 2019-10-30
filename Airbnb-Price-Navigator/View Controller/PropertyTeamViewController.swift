//
//  PropertyTeamViewController.swift
//  Airbnb-Price-Navigator
//
//  Created by Iyin Raphael on 10/30/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit

let reuseIdentifier = "teamCell"
class PropertyTeamViewController: PropertyBaseNavViewController {
    
    var tableView: UITableView!
    let imageName = ["iyin", "connor", "shreyas", "tomas", "jacob"]
    let name = ["Iyin Raphael", "Connor Heraty", "Shreyas Jotish", "Tomas Fox", "Jacob Barlet"]
    let textTitle = ["""
        iOS Developer.
        Responsible for Developing this iOS App.
        """,
        """
        Product Owner. Responsible for model.
        """,
        """
        Worked on Data wrangling, feature
        Engineering and Data Modeling of seasonal
        information Los Angeles Airbnb dataset.
        """,
        """
        Responsible for benchmarking our
        Airbnb predictor app against Tree
        Ensemblt ML models.
        """,
        """
        UX Designer responsible for creating a
        new visual identity for the project.
        """
            ]
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.separatorStyle = .none
        view.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
        tableView.register(PropertyTeamViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }

}

extension PropertyTeamViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? PropertyTeamViewCell else { return UITableViewCell()}
        let image = imageName[indexPath.row]
        let teamName = name[indexPath.row]
        let titleText = textTitle[indexPath.row]
        cell.imageView?.image = UIImage(systemName: image)
        cell.label.text = teamName
        cell.textView.text = titleText
        return cell
    }
    
    
    
}
