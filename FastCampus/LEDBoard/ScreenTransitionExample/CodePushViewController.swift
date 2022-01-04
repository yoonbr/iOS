//
//  CodePushViewController.swift
//  ScreenTransitionExample
//
//  Created by boreum yoon on 2022/01/04.
//

import UIKit

class CodePushViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func tapBackButton(_ sender: UIButton) {
        // 이전화면으로 돌아가기 - popViewController
        self.navigationController?.popViewController(animated: true)
    }
    
}
