//
//  ViewController.swift
//  StudyProject
//
//  Created by boreum yoon on 2021/02/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "Hello Bonnie"
    }

    @IBAction func click1(_ sender: Any) {
        
        self.view.backgroundColor = UIColor.gray
    }
    
    @IBAction func click2(_ sender: Any) {
        
        label.text = "Hello~~"
    }
}

