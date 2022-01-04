//
//  CodePushViewController.swift
//  ScreenTransitionExample
//
//  Created by boreum yoon on 2022/01/04.
//

import UIKit

class CodePushViewController: UIViewController {

    
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
        // 이전화면으로 돌아가기 - popViewController
        self.navigationController?.popViewController(animated: true)
    }
    
}
