//
//  ViewController.swift
//  day_09
//
//  Created by boreum yoon on 2021/10/29.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var myLB: UILabel!
    
    @IBOutlet var myImg: UIImageView!
    // 5. 전구 이미지 변경 - dictionary로 선언
    let lampArr = [true:UIImage(named: "lamp_on.png"),
                   false:UIImage(named: "lamp_off.png")]
    
    // 전구상태 가져오기
    var lampData = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func backGo(_ editView:EditViewController) {
        
        myLB.text = editView.editTF.text
        // lampSwitch의 상태 isOn 가져옴
        lampData = editView.lampSW.isOn
        // 5-1. 이미지 변경이 가능하게
        myImg.image = lampArr[lampData] as! UIImage
        print("ViewController backGo() 실행 \(myLB.text!), \(lampData)")
    }
    
    // edit를 눌렀을때 실행
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("segue 버튼 실행")
        
        // 도착지를 EditViewController로 형변환
        let editView = segue.destination as! EditViewController
        
//        editView.txtData = "메인에서 넘김"
//        editView.swData = false
        
        editView.txtData = myLB.text!
        editView.swData = lampData
        // 내 자신을 넘겨주므로 self 
        editView.mainCon = self
    
    }
}

