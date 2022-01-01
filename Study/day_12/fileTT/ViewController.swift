//
//  ViewController.swift
//  fileTT
//
//  Created by boreum yoon on 2021/11/10.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var myTF: UITextField!
    
    @IBOutlet var myTXT: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //
    @IBAction func goSave(_ sender: UIButton) {
    }
    
    // 파일을 읽기
    @IBAction func goRead(_ sender: UIButton) {
    }
    
    // 기존에 있는 파일 내용 밑에 추가
    @IBAction func goAppend(_ sender: UIButton) {
    }

}

// 특정 파일이 특정 위치에 있는지 확인 - 없으면 생성하도록 해주고, 없으면 아무 진행을 하지 말아야 함
// 기존에 있는 파일을 지워버리고 새로 만드는 방법

// viewDidLoad에서 파일이 있는지 없는지 확인 후 파일을 생성
