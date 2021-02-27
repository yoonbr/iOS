//
//  ViewController.swift
//  ViewSwitching
//
//  Created by boreum yoon on 2021/02/25.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func moveSecond(_ sender: Any) {
        // 출력할 뷰 컨트롤러 객체 만들기
        // SecondViewController 라는 storyboard ID를 가진
        // 뷰 컨트롤러 객체를 가져와서 SecondViewController 타입으로 변환해서 사용
        let secondViewController = self.storyboard?.instantiateViewController(identifier: "SecondViewController") as! SecondViewController
        // 화면 이동할 때 애니메이션 설정
        secondViewController.modalTransitionStyle = .crossDissolve
        // 화면에 출력
        present(secondViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

