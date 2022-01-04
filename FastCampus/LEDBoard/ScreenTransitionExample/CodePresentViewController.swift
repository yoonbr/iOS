//
//  CodePresentViewController.swift
//  ScreenTransitionExample
//
//  Created by boreum yoon on 2022/01/04.
//

import UIKit

class CodePresentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
