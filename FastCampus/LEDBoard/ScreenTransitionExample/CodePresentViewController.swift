//
//  CodePresentViewController.swift
//  ScreenTransitionExample
//
//  Created by boreum yoon on 2022/01/04.
//

import UIKit

class CodePresentViewController: UIViewController {

    @IBOutlet var nameLabel: UILabel!
    // name이라는 string 프로퍼티 추가
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // viewController 에서 전달받은 네임 프로퍼티를 네임 라벨에 표시
        if let name = name {
            self.nameLabel.text = name
            self.nameLabel.sizeToFit()
        }
    }
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}



