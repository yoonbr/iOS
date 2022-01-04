//
//  SeguePresentViewController.swift
//  ScreenTransitionExample
//
//  Created by boreum yoon on 2022/01/04.
//

import UIKit

class SeguePresentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        // 이전화면으로 돌아가기 - dismiss
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
