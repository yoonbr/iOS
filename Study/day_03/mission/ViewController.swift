//
//  ViewController.swift
//  mission
//
//  Created by boreum yoon on 2021/10/21.
//
// ** datePicker에서 설정한 시간에 맞춰 alert 창 띄우는 미션 

import UIKit

class ViewController: UIViewController {
    
    // 4. 사용할 변수 선언
    // objc 함수 updateTime 셀렉터 추가
    let timeSelector: Selector = #selector(ViewController.updateTime)
    let fmt = DateFormatter()
    var count = 0
    // 알람 시간 나타낼 변수 문자열로 선언
    var alarmTime: String?
    // alarm 상태 나타낼 변수
    var alarmFlag = false

    // 1. outlet 연결
    @IBOutlet var nowTime: UITextField!
    @IBOutlet var selectTime: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        }
    
    // 2. timePicker 액션 연결
    @IBAction func timePicker(_ sender: UIDatePicker) {
        
        // sender의 값 선언
        let datePickerView = sender
        
        fmt.dateFormat = "yyyy-MM-dd HH:mm"
        selectTime.text = "선택 시간 : " + fmt.string(from: datePickerView.date)
        fmt.dateFormat = "HH:mm"
        alarmTime = fmt.string(from: datePickerView.date)
    }

    // 3. objc 함수 추가
    @objc func updateTime() {
        let date = NSDate() as Date
        
        fmt.dateFormat = "yyyy-MM-dd HH:mm"
        nowTime.text = "현재 시간 : " + fmt.string(from: date)
        fmt.dateFormat = "HH:mm"
        let currentTime = fmt.string(from: date)
        
        // alert 창 띄울 if문
        if (alarmTime == currentTime) {
            if !alarmFlag {
                let alertOn = UIAlertController(title: "Notice", message: "Alarm", preferredStyle: .alert)
                alertOn.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                present(alertOn, animated: true, completion: nil)
                alarmFlag = true
            }
        } else {
            alarmFlag = false
        }
    }
    
    @IBAction func alarmGo(_ sender: UIButton) {
        
        // 5. 타이머 실행
        Timer.scheduledTimer(
            timeInterval: 1.0, // 1초 간격
            target: self, // 자신 객체 -> 현재 앱 화면
            selector: timeSelector, // 2번에서 선언한 객체
            userInfo: nil, // 사용자 정보
            repeats: true // 반복
        )
    }
}

