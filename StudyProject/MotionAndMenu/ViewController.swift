//
//  ViewController.swift
//  MotionAndMenu
//
//  Created by boreum yoon on 2021/02/26.
//

import UIKit

class ViewController: UIViewController {
    // ViewController가 FirstResponder 가 될 수 있도록
    // 프로퍼티 재정의
    override var canBecomeFirstResponder: Bool {
        get{
            return true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // viewController가 FirstResponder가 되도록 설정
        self.becomeFirstResponder()
        
        // 길게 눌렀을 때 호출할 메소드 설정
        // target : 누가 가지고 있는지, selector : 함수
        let longPress = UILongPressGestureRecognizer(
            target: self, action: #selector(handleLongPress))
        // 길게 눌렀을 때의 옵션 설정
        // 얼마정도 눌렀을 때 동작 할 것 인지
        longPress.minimumPressDuration = 2.0
        // 어느정도 움직여도 무방한지
        longPress.allowableMovement = 15
        // 현재 뷰를 길게 누르면 longPress 수행
        view.addGestureRecognizer(longPress)
        
    }
    
    // 뷰를 길게 누르면 호출될 메소드
    // 이벤트처리 sender:
    @objc func handleLongPress(sender:UILongPressGestureRecognizer){
        // 메뉴 출력하기
        
        // 메뉴 생성
        // select에 이름 정하기 - menuEvent
        let menuItem = UIMenuItem(title: "Menu", action: #selector(menuEvent))
        // 메뉴를 메뉴 컨트롤러에 추가
        UIMenuController.shared.menuItems = [menuItem]
        // 출력할 좌표 설정
        let pt = sender.location(in: self.view)
        // 메뉴 출력
        UIMenuController.shared.showMenu(from: self.view, rect: CGRect(x: pt.x, y: pt.y, width: 100, height: 100))
    }
    
    // 메뉴를 눌렀을 때 호출될 함수
    @objc func menuEvent(){
        NSLog("Click Menu")
    }
    
    
    // 흔들기가 시작되면 호출될 메소드
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        // 메시지 출력 대화상자를 만들어서 출력
        let alert = UIAlertController(title: "Shake", message: "상속받은 메소드 재정의", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
}

