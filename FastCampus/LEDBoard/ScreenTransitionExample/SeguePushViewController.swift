//
//  SeguePushViewController.swift
//  ScreenTransitionExample
//
//  Created by boreum yoon on 2022/01/04.
//

import UIKit

class SeguePushViewController: UIViewController {

    @IBOutlet var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // 이전화면으로 돌아가기 - popViewController
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    // rootViewController로 이동
        // self.navigationController?.popToRootViewController(animated: true)
    }
}
