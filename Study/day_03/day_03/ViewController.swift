//
//  ViewController.swift
//  day_03
//
//  Created by boreum yoon on 2021/10/13.
//
// * Timer 생성
// 1. 실행할 함수 생성
// 2. 시간의 흐름을 설정 정의 -> 1 에서 정의한 함수 지정
// 3. 프로그램 시작과 함께 2번 정의 객체 호출

import UIKit

class ViewController: UIViewController {
    
    // 공용으로 사용하게끔 밖으로 빼기
    let fmt = DateFormatter()
    
    // 시간 레이블은 아웃렛 변수, 데이트피커는 액션
    @IBOutlet var currLb: UILabel!
    
    // sender로 가져오는 값을 가지고 작업 진행
    @IBOutlet var selectLb: UILabel!
    
    // 4. 실행할때 보여질 멤버변수 선언
    var i = 0

    // 1. 실행할 Objc 테스트 함수 정의
    @objc func updateTime() {
        // 5. i가 1씩 증가할 수 있는걸 확인할 수 있도록 작성
        i += 1
        currLb.text = "print updateTime \(i)"
    }
    
    // 5. 실행할 Objc 함수 정의 - 현재시간 나타낼 함수
    @objc func updateTime2() {
        
        // 6. date 상수 선언 후 date로 형변환
        let now = NSDate() as Date
    
        currLb.text = "현재시간 : " + fmt.string(from: now)
    }
    
    // 2. 시간의 흐름을 설정 정의 -> 1 에서 정의한 updateTime 함수 지정
    // 7. 현재시간 나타낼 함수로 바꾸기
    let ts = #selector(updateTime2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        // 같은 이름의 함수이지만 여러개의 매개변수가 있는 경우 - 오버로딩
        // 3. 객체 호출
        Timer.scheduledTimer(
            timeInterval: 1.0, // 1초 간격
            target: self, // 자신 객체 -> 현재 앱 화면
            selector: ts, // 2번에서 선언한 객체
            userInfo: nil, // 사용자 정보
            repeats: true // 반복
            )
        }
    
    @IBAction func changeDP(_ sender: UIDatePicker) {
        // 1. sender로 콘솔창에 값 출력
        // print("\(sender.date)")
        
        // 3. 원하는 형태의 dateFormat 설정
        // let fmt = DateFormatter()
        // fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        // 출력
        print(fmt.string(from: sender.date))
        
        // 2. selectLb에 값 가져오기
        // selectLb.text = "선택시간 : \(sender.date)"
        
        // 4. fmt 사용해서 값 가져오기
        selectLb.text = "선택시간 : " + fmt.string(from: sender.date)
    }
}

