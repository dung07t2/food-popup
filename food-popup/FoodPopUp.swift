//
//  FoodPopUp.swift
//
//  Created by Dung Le Huy on 2/4/19.
//  Copyright © 2019 Dung Le Huy. All rights reserved.
//

import UIKit

class FoodPopUp: NSObject {
    
    lazy var blackView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        view.alpha = 0
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDismissView))
        view.addGestureRecognizer(tapGesture)
        
        return view
        
    }()
    
    let containerView: CustomPopUPView = {
        let cv = CustomPopUPView()
        cv.backgroundColor = .white
        
        cv.layer.cornerRadius = 25
        return cv
    }()
    
    lazy var addButton : UIButton = {
        let cb = UIButton(type: .system)
        cb.setTitle("Add", for: .normal)
        cb.tintColor = .white
        cb.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)
        cb.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        cb.layer.cornerRadius = 30
        cb.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return cb
    }()
    lazy var cancelButton : UIButton = {
        let cb = UIButton(type: .system)
        cb.setTitle("Cancel", for: .normal)
        cb.tintColor = .white
        cb.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        cb.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        cb.layer.cornerRadius = 30
        cb.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        return cb
    }()
    
    let foodPreviewImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = #colorLiteral(red: 0.9347808957, green: 0.9292238355, blue: 0.9390522838, alpha: 1)
        iv.layer.cornerRadius = 100
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let foodName: UILabel = {
        let text = UILabel()
        text.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        return text
    }()
    
    let caloriesLabel: UILabel = {
        let text = UILabel()
        text.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        text.textColor = .black
        text.text = "Calories"
        return text
    }()
    
    let caloriesValue: UILabel = {
        let text = UILabel()
        text.font = UIFont.systemFont(ofSize: 25, weight: .light)
        text.textColor = .gray
        return text
    }()
    
    let fatsLabel: UILabel = {
        let text = UILabel()
        text.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        text.textColor = .black
        text.text = "Fats"
        return text
    }()
    
    let fatsValue: UILabel = {
        let text = UILabel()
        text.font = UIFont.systemFont(ofSize: 25, weight: .light)
        text.textColor = .gray
        return text
    }()
    
    let sugarsLabel: UILabel = {
        let text = UILabel()
        text.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        text.textColor = .black
        text.text = "Sugars"
        return text
    }()
    
    let sugarsValue: UILabel = {
        let text = UILabel()
        text.font = UIFont.systemFont(ofSize: 25, weight: .light)
        text.textColor = .gray
        return text
    }()
    
    
    
    var delegate: FoodPopupDelegate?
    
    @objc func handleAdd() {
        print(delegate)
        delegate?.shouldAddFood()
    }
    
    @objc func handleCancel() {
        print(delegate)
        delegate?.shouldCancelFood()
    }
    
    // name, caolries, fats, sugar
    
    
    override init() {
        super.init()
    }
    
    
    func showMenu(title: String, calories:String, fat:String, sugar: String) {
        //show menu
        guard let window = UIApplication.shared.keyWindow else {return}
        
        window.addSubview(blackView)
        window.addSubview(containerView)
        blackView.frame = window.frame
        let width: CGFloat = window.frame.width
        let y = window.frame.height - 600
        
        containerView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 500)
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 1
            self.containerView.frame = CGRect(x: 0, y: y, width: width, height: 600)
        }, completion: nil)
        
        containerView.addSubview(cancelButton)
        cancelButton.anchor(top: nil, left: containerView.leftAnchor, right: containerView.rightAnchor, bottom: containerView.safeAreaLayoutGuide.bottomAnchor, paddingTop: 0, paddingLeft: 50, paddingRight: 50, paddingBottom: 16, width: 0, height: 60)
        containerView.addSubview(addButton)
        addButton.anchor(top: nil, left: containerView.leftAnchor, right: containerView.rightAnchor, bottom: cancelButton.topAnchor, paddingTop: 0, paddingLeft: 16, paddingRight: 16, paddingBottom: 16, width: 0, height: 60)
        containerView.addSubview(foodPreviewImageView)
        foodPreviewImageView.anchor(top: containerView.topAnchor, left: nil, right: nil, bottom: nil, paddingTop: -50, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 200, height: 200)
        foodPreviewImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0).isActive = true
        
        foodName.text = title
        containerView.addSubview(foodName)
        foodName.anchor(top: foodPreviewImageView.bottomAnchor, left: nil, right: nil, bottom: nil, paddingTop: 16, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        foodName.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0).isActive = true
        
        // set values
        caloriesValue.text = calories
        fatsValue.text = fat
        sugarsValue.text = sugar
        foodPreviewImageView.image = UIImage(named: title)
        
        let firstHorizontalStackView = UIStackView(arrangedSubviews: [caloriesLabel,caloriesValue])
        firstHorizontalStackView.distribution = .fillEqually
        let secondHorizontalStackView = UIStackView(arrangedSubviews: [fatsLabel,fatsValue])
        secondHorizontalStackView.distribution = .fillEqually
        let thirdHorizontalStackView = UIStackView(arrangedSubviews: [sugarsLabel,sugarsValue])
        thirdHorizontalStackView.distribution = .fillEqually
        //
        //
        let verticalStackView = UIStackView(arrangedSubviews: [firstHorizontalStackView,secondHorizontalStackView,thirdHorizontalStackView])
        verticalStackView.distribution = .fillEqually
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 5
        
        containerView.addSubview(verticalStackView)
        verticalStackView.anchor(top: foodName.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, bottom: nil, paddingTop: 16, paddingLeft: 32, paddingRight: 32, paddingBottom: 0, width: 0, height: 170)
        
        
    }
    
    @objc func handleDismissView() {
        dismissView()
    }
    
    fileprivate func dismissView() {
        guard let window = UIApplication.shared.keyWindow else {return}
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.blackView.alpha = 0
            self.containerView.frame = CGRect(x: 0, y: window.frame.height+1, width: window.frame.width, height: 400)
        }, completion: { (_) in
            self.blackView.removeFromSuperview()
        })
    }
    
}


class CustomPopUPView: UIView {
    
}

