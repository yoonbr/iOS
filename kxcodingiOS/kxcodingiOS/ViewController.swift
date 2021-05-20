//
//  ViewController.swift
//  kxcodingiOS
//
//  Created by boreum yoon on 2021/05/19.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBAction func updateLabel(_ sender: Any) {
        label.text = "Hello, iOS"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

