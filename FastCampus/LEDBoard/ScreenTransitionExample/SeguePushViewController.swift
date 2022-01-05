//
//  SeguePushViewController.swift
//  ScreenTransitionExample
//
//  Created by boreum yoon on 2022/01/04.
//

import UIKit

class SeguePushViewController: UIViewController {

    @IBOutlet var nameLabel: UILabel!
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 전달 받은 데이터를 표시
        self.nameLabel.text = name
        self.nameLabel.sizeToFit()
    }
    
    // 이전화면으로 돌아가기 - popViewController
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    // rootViewController로 이동
        // self.navigationController?.popToRootViewController(animated: true)
    }
}

 
