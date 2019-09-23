//
//  DropDownTextField.swift
//  Airbnb-Price-Navigator
//
//  Created by Iyin Raphael on 9/18/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit

class DropDownTextField: UIView {
    
    //MARK: - Property
    private var options: [String]
    let button = UIButton(type: .custom)
    private var initialHeight: CGFloat = 0
    private let rowHeight: CGFloat = 40
    
    //MARK: - UI
    let tapView: UIView = UIView()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.bounces = false
        tableView.backgroundColor = .clear
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.separatorStyle = .none
        return tableView
    }()
    
    let animationView = UIView()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.returnKeyType = .done
        textField.keyboardType = .alphabet
        textField.borderStyle = .line
        textField.rightViewMode = .always
        return textField
    }()
    
    init(frame: CGRect, title: String, options: [String]) {
        self.options = options
        super.init(frame: frame)
        self.textField.text = title
        calculateHeight()
        setupViews()
    }
    
    private override init(frame: CGRect) {
        options = []
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func animateMenu() {
        //
    }

}


extension DropDownTextField {
    
    private func calculateHeight() {
        self.initialHeight = self.bounds.height
        let rowCount = self.options.count + 1 //Add one so that you can include 'other'
        let newHeight = self.initialHeight + (CGFloat(rowCount) * rowHeight)
        self.frame.size = CGSize(width: self.frame.width, height: newHeight)
    }
    
    
    private func setupViews() {
        removeSubviews()
        addTextField()
        addTapView()
        addTableView()
        addAnimationView()
    }
    
    private func removeSubviews() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    
    private func addTextField() {
        self.addSubview(textField)
        button.setImage(UIImage(named: "slide-down"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame =  CGRect(x: 0, y: 0, width: 12, height: 12)
        textField.rightView = button
       
        //        textField.delegate = self
    }
    
    private func addTapView() {
        tapView.translatesAutoresizingMaskIntoConstraints = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(animateMenu))
        tapView.addGestureRecognizer(tapGesture)
        addSubview(tapView)
        tapView.constraintsPinTo(leading: leadingAnchor, trailing: trailingAnchor, top: topAnchor, bottom: textField.bottomAnchor)
    }
    
    private func addTableView() {
        //         tableView.delegate = self
        //         tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(tableView)
        tableView.constraintsPinTo(leading: leadingAnchor, trailing: trailingAnchor, top: textField.bottomAnchor, bottom: bottomAnchor)
        //        tableView.isHidden = true
    }
    
    private func addAnimationView() {
        self.addSubview(animationView)
        animationView.frame = CGRect(x: 0.0, y: initialHeight, width: bounds.width, height: bounds.height - initialHeight)
        self.sendSubviewToBack(animationView)
        animationView.backgroundColor = .white
        //        animationView.isHidden = true
    }
}


extension UIView {
    
    func constraintsPinTo(leading: NSLayoutXAxisAnchor, trailing: NSLayoutXAxisAnchor, top: NSLayoutYAxisAnchor, bottom: NSLayoutYAxisAnchor) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: leading),
            self.trailingAnchor.constraint(equalTo: trailing),
            self.topAnchor.constraint(equalTo: top),
            self.bottomAnchor.constraint(equalTo: bottom)
        ])
    }
}


extension UIImage {
    
    enum Theme {
        case dropDown
        case dropUp
        
        var name: String {
            switch self {
            case .dropDown: return "slide-down"
            case .dropUp: return "slide-up"
            }
        }
        
        var image: UIImage {
            return UIImage(named: self.name)!
        }
    }
}
