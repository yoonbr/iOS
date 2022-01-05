//
//  CodePresentViewController.swift
//  ScreenTransitionExample
//
//  Created by boreum yoon on 2022/01/04.
//

import UIKit
// 이전화면에 데이터를 넘겨줄 프로토콜 정의
protocol SendDataDelegate: AnyObject {
    func sendData(name: String)
}

class CodePresentViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    // name이라는 string 프로퍼티 추가
    var name: String?
    // CodePresentViewController에 protocol 타입의 변수 선언 - weak
    weak var delegate: SendDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // viewController 에서 전달받은 네임 프로퍼티를 네임 라벨에 표시
        if let name = name {
            self.nameLabel.text = name
            self.nameLabel.sizeToFit()
        }
    }
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        // 이전 화면에 전달할 데이터를 샌드 데이터 함수 파라미터에 작성
        self.delegate?.sendData(name: "Bonnie")
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}



