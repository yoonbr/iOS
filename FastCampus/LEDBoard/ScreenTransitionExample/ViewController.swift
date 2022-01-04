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
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "CodePresentViewController") else { return }
        
        // modally -> full screen 변경
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
    
    // navigation stack에 codepush
    @IBAction func tapCodePushButton(_ sender: UIButton) {
        // instantiateViewController메소드로 storyboard에 있는 viewController를 인스턴스화, 옵셔널 변환이므로 guard문 사용
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "CodePushViewController") else { return }
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    
}

