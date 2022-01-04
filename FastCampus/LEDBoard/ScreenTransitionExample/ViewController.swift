//
//  ViewController.swift
//  ScreenTransitionExample
//
//  Created by boreum yoon on 2022/01/04.
//

import UIKit

class ViewController: UIViewController {
     
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
    
    
}


