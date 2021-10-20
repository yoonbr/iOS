//
//  ViewController.swift
//  TimerTT
//
//  Created by boreum yoon on 2021/10/13.
//

import UIKit

class ViewController: UIViewController {
    
    // 1. tf 가져오기
    @IBOutlet var countLbl: UITextField!
    
    // 3. 눌렀을 때 시간의 값 가져와야함
    var tf = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    // 4. objc 함수 생성 - 들어올 때 마다 1씩 빼기
    @objc func updateTime() {
        tf -= 1
        
        // tf가 0보다 작아지면 0으로 강제 변환
//        if tf < 0 {
//            tf = 0
//        }
        
        countLbl.text = "\(tf)"
        
        // tf가 0일 경우 tt의 실행을 중단시킴
        if tf <= 0 {
            tt?.invalidate() // 초기화
            tt = nil // 객체를 없애버림
            
            // 1018 - add alert
            let alert = UIAlertController(title: "Notice", message: "타이머 종료", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "종료", style: .cancel, handler: nil))
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    // 5. selector 선언
    let ts = #selector(updateTime)
    
    // scheduledTimer 변수 생성 - Timer
    // Timer를 받을 멤버 변수
    var tt:Timer?
    
    // 2. 버튼 메소드 생성
    @IBAction func startBtn(_ sender: UIButton) {
        tf = Int(countLbl.text!)!
        
        // 1018 - add alert
        if tf <= 0 {
            let alert = UIAlertController(title: "알림", message: "0 이상의 숫자를 입력하세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
            
            present(alert, animated: true, completion: nil)
            
        } else {
        
        // * 찍어보기 - int 형변환
        // tf에 넣은 값 출력
        // print(Int(countLbl.text!))
        
        // 6. scheduledTimer 실행
        // 멤버 변수 선언 후 tt에게 값 부여 
        tt = Timer.scheduledTimer(
            timeInterval: 1.0, // 1초 간격
            target: self, // 자신 객체 -> 현재 앱 화면
            selector: ts, // 2번에서 선언한 객체
            userInfo: nil, // 사용자 정보
            repeats: true // 반복
            )
        }
    }
}

