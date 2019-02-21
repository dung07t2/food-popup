//
//  ViewController.swift
//  food-popup
//
//  Created by Dung Le Huy on 2/22/19.
//  Copyright © 2019 Dung Le Huy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let foodLauncher = FoodPopUp()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func btnShowPopup(_ sender: UIButton) {
        foodLauncher.showMenu(title: "Banana", calories: "10", fat: "0.8", sugar: "1.2")
        foodLauncher.delegate = self

    }
}

extension ViewController: FoodPopupDelegate {
    func shouldAddFood() {
        //        addItem()
        foodLauncher.handleDismissView()
    }
    
    func shouldCancelFood() {
        foodLauncher.handleDismissView()
        print("test")
        
    }
    
}


