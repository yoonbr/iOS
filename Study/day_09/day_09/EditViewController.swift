//
//  EditViewController.swift
//  day_09
//
//  Created by boreum yoon on 2021/10/29.
//

import UIKit

class EditViewController: UIViewController {
    
    var txtData = ""
    var swData = true
    // viewController를 상속받는 변수를 선언
    var mainCon:ViewController?

    
    @IBOutlet var editTF: UITextField!
    
    // outlet으로 선언 
    @IBOutlet var lampSW: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 데이터 받은 후 확인
        print("Edit viewDidLoad 실행 : \(txtData), \(swData)")
        
        // 들어오는 데이터를 위치에 맞게 선언
        editTF.text = txtData
        // 스위치의 상태를 변경
        lampSW.isOn = swData
        
    }
    
    // 수정완료를 누르면 동작 실행
    // 현재 있는 창을 닫고 돌아감
    @IBAction func mainGO(_ sender: UIButton) {
        // viewController에 있는 backGo 함수 실행
        // editController를 받기 위해 self
        mainCon?.backGo(self)
        // 현재 열려진 창 닫기 
        navigationController?.popViewController(animated: true)
    }
}
