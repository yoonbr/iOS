//
//  ViewController.swift
//  day_08
//
//  Created by boreum yoon on 2021/10/27.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func moveCalendar(_ sender: UIButton) {
        tabBarController?.selectedIndex = 2
    }
    
    @IBAction func moveLamp(_ sender: UIButton) {
        tabBarController?.selectedIndex = 1
    }
    
    @IBAction func movePicker(_ sender: UIButton) {
        tabBarController?.selectedIndex = 3
    }
    
    @IBAction func moveAlert(_ sender: UIButton) {
        tabBarController?.selectedIndex = 4
    }
    
}

