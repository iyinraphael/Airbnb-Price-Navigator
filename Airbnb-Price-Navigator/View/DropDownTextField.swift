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
    var boldColor = UIColor.black
    var lightColor = UIColor.white
    var dropDownColor = UIColor.gray
    var font = UIFont.systemFont(ofSize: 12, weight: .light)
    
    private var options: [String]
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
    
    lazy var newButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage.Theme.dropDown.image, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: 0, y: 0, width: 12, height: 12)
        return button
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.textColor = boldColor
        textField.returnKeyType = .done
        textField.keyboardType = .alphabet
        textField.borderStyle = .line
        return textField
    }()
     
    init(frame: CGRect, title: String, options: [String]) {
        self.options = options
        super.init(frame: frame)
        self.textField.placeholder = title
        calculateHeight()
        setUpViews()
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
        let rowCount = self.options.count
        let newHeight = self.initialHeight + (CGFloat(rowCount) * rowHeight)
        self.frame.size = CGSize(width: self.frame.width, height: newHeight)
    }
    
    private func setUpViews() {
        removeSubView()
        //addSlideIndicator()
        addTextField()
        addTapView()
        addTableView()
        addAnimationView()
    }
    
    
    private func removeSubView() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    private func addTextField() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.centerYAnchor.constraint(equalTo: topAnchor, constant: initialHeight / 2),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        ])
        textField.rightView = newButton
        textField.rightViewMode = .always
        textField.font = self.font
        //        textField.delegate = self
    }
    
    private func addTapView() {
        tapView.translatesAutoresizingMaskIntoConstraints = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(animateMenu))
        tapView.addGestureRecognizer(tapGesture)
        addSubview(tapView)
        tapView.constraintsPinTo(leading: leadingAnchor,
                                 trailing: trailingAnchor,
                                 top: topAnchor,
                                 bottom: textField.bottomAnchor)
    }
    
    private func addTableView() {
        //         tableView.delegate = self
        //         tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(tableView)
        tableView.constraintsPinTo(leading: leadingAnchor,
                                   trailing: trailingAnchor,
                                   top: textField.bottomAnchor,
                                   bottom: bottomAnchor)
        //        tableView.isHidden = true
    }
    
    private func addAnimationView() {
        self.addSubview(animationView)
        animationView.frame = CGRect(x: 0.0, y: initialHeight, width: bounds.width, height: bounds.height - initialHeight)
        animationView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 0.0).isActive = true
        self.sendSubviewToBack(animationView)
        animationView.backgroundColor = dropDownColor
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
