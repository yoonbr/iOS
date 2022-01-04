//
//  ViewController.swift
//  ScreenTransitionExample
//
//  Created by boreum yoon on 2022/01/04.
//

import UIKit

class ViewController: UIViewController, SendDataDelegate {
     
    @IBOutlet var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
     
    // codePresnet
    @IBAction func tapCodePresentButton(_ sender: Any) {
        // 뷰 컨트롤러를 인스턴스화 해주는 메소드에 전환된 화면에 뷰 컨트롤러 클래스 타입으로 다운캐스팅
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "CodePresentViewController") as? CodePresentViewController else { return }
        // 프로퍼티에 접근해서 값 넘겨주기
        viewController.name = "Bonnie"
        // modally -> full screen 변경
        viewController.modalPresentationStyle = .fullScreen
        // 이전 화면 뷰컨트롤러에서 delegate 위임, SendDataDelegate 프로토콜 채택
        viewController.delegate = self
        self.present(viewController, animated: true, completion: nil)
    }
    
    // navigation stack에 codepush
    @IBAction func tapCodePushButton(_ sender: UIButton) {
        // instantiateViewController메소드로 storyboard에 있는 viewController를 인스턴스화, 옵셔널 변환이므로 guard문 사용
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "CodePushViewController") as? CodePushViewController else { return }
        // 프로퍼티에 접근해서 값 넘겨주기
        viewController.name = "Bonnie"
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    // 프로토콜 준수 위해 sendData 메소드 정의
    func sendData(name: String) {
        // sendData 메소드의 name 파라미터를 nameLabel에 표시
        self.nameLabel.text = name
        self.nameLabel.sizeToFit()
    }
}


