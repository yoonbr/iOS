//
//  ViewController.swift
//  day_05
//
//  Created by boreum yoon on 2021/10/18.
//

import UIKit

class AlertController: UIViewController {

    // 1. imageView는 결과만 보면 되므로 Outlet
    @IBOutlet var myImg: UIImageView!
    
    // 3. 이미지를 변수로 선언해서 작업
    let imageOn = UIImage(named: "lamp_on.png")
    let imageOff = UIImage(named: "lamp_off.png")
    let imageRemove = UIImage(named: "lamp_remove.png")
    
    // 4. 전구의 상태를 나타내는 변수
    var isLamp = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // 2. button은 이벤트를 발생하므로 Action
    @IBAction func onBtn(_ sender: UIButton) {
       
        // 5. 전구가 켜져있으면 경고창을 띄우고 꺼져있으면 켜기
        if isLamp {
            // 5-1. 경고창 생성
            let alert = UIAlertController(title: "알림", message: "켜짐 상태 입니다.", preferredStyle: .alert)
            
            // 5-3. button 생성 - UIAlertAction
            let ac = UIAlertAction(title: "취소", style: .default, handler: nil)
            let ac2 = UIAlertAction(title: "확인", style: .default, handler: nil)
        
            // 이런 방식으로 해도 상관 없음.
//            alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
//            alert.addAction(UIAlertAction(title: "끄기", style: .default, handler: { _ in
//                self.myImg.image = self.imageOff
//                self.isLamp = false
//            }))
            
            // 5-4. 경고창 버튼 추가
            alert.addAction(ac)
            alert.addAction(ac2)
            
            // 5-2. 경고창 실행
            present(alert, animated: true, completion: nil)
            
        } else {
            myImg.image = imageOn
            isLamp = true
        }
    }
    
    
    @IBAction func offBtn(_ sender: UIButton) {
        // 6. 꺼져있을 땐 아무 작업 실행X, 끄는 버튼을 누르면 경고창에 버튼 두개 생성, 실행
        if isLamp {
            
            // 6-1.
            let alert = UIAlertController(
                title: "알림",
                message: "정말 끄시겠습니까?",
                preferredStyle: .alert
            )
            
            // 6-3. 버튼 2개 만들기
            let cancelBtn = UIAlertAction(
                title: "취소",
                style: .default,
                handler: nil
                )
            
            // 6-5. 끄는 작업 실행
            let offBtn = UIAlertAction(
                title: "끄기",
                style: .default,
                // 핸들러에 들어가야하는 매개변수 함수이름 {(매개변수타입) -> void}
                handler: lampOff // handler -> 이 버튼을 눌렀을 때 실행할 함수 지정
            )
            
            // 6-4. add 순서 중요
            alert.addAction(offBtn)
            alert.addAction(cancelBtn)
            
            // 6-2. alert 실행
            present(alert, animated: true, completion: nil)
            
        }
        else {
        }
    }
    
    // 6-6. 6-5의 handler에 넣을 임의 함수 생성 - UIAlertAction 함수만 받을 수 있음, 재사용 가능
    func lampOff(_ aa:UIAlertAction) { // offBtn -> onBtn 일 때 실행시킬 함수, 전구를 끄는 함수
        myImg.image = imageOff
        isLamp = false
    }

    @IBAction func removeBtn(_ sender: UIButton) {
        // 7. 제거를 누르면 3가지 선택사항을 받고, 액션 실행
        let alert = UIAlertController(
            title: "전구 제거",
            message: "전구를 제거하시겠습니까?",
            preferredStyle: .alert
        )
        
        let offBtn = UIAlertAction(
            title: "아니오,끕니다",
            style: .default,
            // 핸들러에 들어가야하는 매개변수 함수이름 {(매개변수타입) -> void}
            handler: lampOff // handler -> 이 버튼을 눌렀을 때 실행할 함수 지정
        )
        
        let onBtn = UIAlertAction(
            title: "아니오,켭니다",
            style: .default,
            // closure : 한번만 실행하는 익명 함수
            // handler -> 이 버튼을 눌렀을 때 실행할 함수 클로저로 정의
            handler:
                { xx in
                    // error? -> self를 사용해서 멤버로 인식시킴 (멤버 요소에 반드시 필요)
                    self.myImg.image = self.imageOn
                    self.isLamp = true
            }
        )
        
        let removeBtn = UIAlertAction(
            title: "제거합니다",
            style: .destructive,
            // 핸들러에 들어가야하는 매개변수 함수이름 {(매개변수타입) -> void}
            handler:
                { yy in
                self.myImg.image = self.imageRemove
                self.isLamp = false
            }
        )
        
        alert.addAction(onBtn)
        alert.addAction(offBtn)
        alert.addAction(removeBtn)
        
        present(alert, animated: true, completion: nil)
        
    }
}

