//
//  DetailController.swift
//  day_10
//
//  Created by boreum yoon on 2021/11/01.
//

import UIKit

class DetailController: UIViewController {
    
    // 번호를 넘기기 위해 Int로 선언
    var detailLbNum = 0
    
    // 2-5. detailLB outlet으로 선언
    // **-1. textField outlet으로 바꿔서 선언
    @IBOutlet var detailTF: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 2-2. 선언한 detailLB 변수에 넘어가는 데이터 확인
        // print("detailLB: \(detailTF)")
        
        // 2-6. detailLB로 값을 넣어줌
        // 전역변수이므로 호출이 가능
        detailTF.text = txtArr[detailLbNum]
    }
    
    // **-2. 수정 버튼 액션 추가
    @IBAction func goBtn(_ sender: UIButton) {
        
        // **-4. 텍스트필드의 글자를 txt배열에 바꿔서 선언 
        txtArr[detailLbNum] = detailTF.text!
        
        // **-3. 닫는 기능 추가
        navigationController?.popViewController(animated: true)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
