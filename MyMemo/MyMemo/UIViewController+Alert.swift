//
//  UIViewController+Alert.swift
//  MyMemo
//
//  Created by boreum yoon on 2021/04/27.
//
// UIKit으로 변경

import UIKit

// UIViewController를 상속하는 모든 클래스에서 우리가 구현할 메소드를 사용할 수 있게 extension

extension UIViewController {
    // 경고창 제목과 메시지를 받는 메소드 선언
    func alert(title: String = "알림", message: String) {
        
        // 경고창 선언시 UIAlertController 사용
        // 첫번째 파라미터는 제목, 두번째 파라미터는 경고창 메시지, 세번째 파라미터는 경고창 스타일
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // 버튼 생성 후 AlertController에 추가
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        
        // present 메소드로 경고창 화면에 표시
        present(alert, animated: true, completion: nil)
    }
}
