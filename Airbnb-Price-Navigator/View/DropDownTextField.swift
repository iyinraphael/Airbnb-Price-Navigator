//
//  DropDownTextField.swift
//  Airbnb-Price-Navigator
//
//  Created by Iyin Raphael on 9/18/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit

protocol DropDownTextFieldDelegate {
    func menuDidAnimate(up: Bool)
    func optionSelected(option: String)
}

class DropDownTextField: UIView {
    
    //MARK: - Property
    var boldColor = UIColor.black
    var lightColor = UIColor.white
    var dropDownColor = UIColor.white
    var font = UIFont.systemFont(ofSize: 12, weight: .light)
    var delegate: DropDownTextFieldDelegate?
    
    private var options: [String]
    private var initialHeight: CGFloat = 0
    private let rowHeight: CGFloat = 40
    var isDroppedDown = false
    
    
    
    //MARK: - UI
    let tapView: UIView = UIView()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DropDownCell.self, forCellReuseIdentifier: "option")
        tableView.bounces = false
        tableView.backgroundColor = .clear
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.separatorStyle = .none
        tableView.isOpaque = true
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
        let textField = UITextField()
        textField.textColor = boldColor
        textField.returnKeyType = .done
        textField.keyboardType = .alphabet
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
        menuAnimate(up: isDroppedDown)
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
        
        textField.layer.borderWidth = 0.3
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.rightView = newButton
        textField.rightViewMode = .always
        textField.font = self.font
        textField.delegate = self
    }
    
    private func addTapView() {
        tapView.translatesAutoresizingMaskIntoConstraints = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(animateMenu))
        tapView.addGestureRecognizer(tapGesture)
        addSubview(tapView)
        tapView.layer.borderColor = UIColor.gray.cgColor
        tapView.constraintsPinTo(leading: leadingAnchor,
                                 trailing: trailingAnchor,
                                 top: topAnchor,
                                 bottom: textField.bottomAnchor)
    }
    
    private func addTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isOpaque = true
        self.addSubview(tableView)
        tableView.constraintsPinTo(leading: leadingAnchor,
                                   trailing: trailingAnchor,
                                   top: textField.bottomAnchor,
                                   bottom: bottomAnchor)
       tableView.isHidden = true
    }
    
    private func addAnimationView() {
        self.addSubview(animationView)
        animationView.frame = CGRect(x: 0.0,
                                     y: initialHeight,
                                     width: 335,
                                     height: bounds.height - initialHeight)
        animationView.topAnchor.constraint(equalTo: textField.bottomAnchor,
                                           constant: 0.0)
                                           .isActive = true
        animationView.bottomAnchor.constraint(equalTo: tableView.bottomAnchor,
                                            constant: 0.0)
                                            .isActive = true
        self.sendSubviewToBack(animationView)
        animationView.backgroundColor = dropDownColor
        animationView.layer.borderWidth = 0.3
        animationView.layer.borderColor = UIColor.lightGray.cgColor
        animationView.isHidden = true
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


extension DropDownTextField: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "option") as? DropDownCell ?? DropDownCell()
        cell.cellFont = font
        let title =  options[indexPath.row]
        cell.configureCell(with: title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / CGFloat(options.count + 1)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == options.count {
            //otherChosen()
        } else {
            let chosen = options[indexPath.row]
            textField.text = chosen
            self.delegate?.optionSelected(option: chosen)
            animateMenu()
        }
    }
}

extension DropDownTextField {

    private func menuAnimate(up: Bool) {
        let downFrame = animationView.frame
        let upFrame = CGRect(x: 0, y: self.initialHeight, width: self.bounds.width, height: 0)
        animationView.frame = up ? downFrame : upFrame
        animationView.isHidden = false
        tableView.isHidden = true

        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
            self.animationView.frame = up ? upFrame : downFrame
        }, completion: { (bool) in
            self.isDroppedDown = !self.isDroppedDown
            if self.isDroppedDown == true {
                self.newButton.setImage(UIImage.Theme.dropUp.image, for: .normal)
            }
            else {
                self.newButton.setImage(UIImage.Theme.dropDown.image, for: .normal)}
            self.animationView.isHidden = up
            self.animationView.frame = downFrame
            self.tableView.isHidden = up
            self.delegate?.menuDidAnimate(up: up)
        })
    }
}

extension DropDownTextField: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        let capitalized = text.capitalized
        textField.text = capitalized
        delegate?.optionSelected(option: capitalized)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        return true
    }
    
    func otherChosen() {
        animateMenu()
        textField.text = ""
        textField.becomeFirstResponder()
    }
}
