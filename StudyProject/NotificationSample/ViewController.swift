//
//  ViewController.swift
//  NotificationSample
//
//  Created by boreum yoon on 2021/02/25.
//

import UIKit

class ViewController: UIViewController {

    
    @IBAction func login(_ sender: Any) {
        let loginDlg = UIAlertController(title: nil, message: "LOGIN", preferredStyle: .alert)
        self.present(loginDlg, animated: true)
        
        // 텍스트 필드 추가
        loginDlg.addTextField(configurationHandler: {(tf) -> Void in
            tf.placeholder = "아이디를 입력하세요"
            tf.isSecureTextEntry = false
        })
        
        loginDlg.addTextField(configurationHandler: {(tf) -> Void in
            tf.placeholder = "비밀번호를 입력하세요"
            tf.isSecureTextEntry = true
        })
        
        // 버튼을 추가해서 눌렀을 때
        let cancel = UIAlertAction(title: "cancle", style: .cancel)
        
        let ok = UIAlertAction(title: "ok", style: .default, handler: {(button) -> Void in
            let id = loginDlg.textFields![0].text
            let pw = loginDlg.textFields![1].text
            
            self.lblNoti.text = "아이디:\(id!) 비밀번호:\(pw!)"
        })
        
        loginDlg.addAction(cancel)
        loginDlg.addAction(ok)
    }
    
    @IBOutlet weak var lblNoti: UILabel!
    
    @IBAction func callDialog(_ sender: Any) {
        let dlg = UIAlertController(title: "대화상자", message: "Local Notification", preferredStyle: .alert)
        
        // 대화상자에 추가할 버튼 생성
        let cancel = UIAlertAction(title: "cancle", style: .cancel)
        
        let ok = UIAlertAction(title: "ok", style: .default, handler: {(alert) -> Void in
            self.lblNoti.text = "확인 버튼 클릭"
            
        })
        
        dlg.addAction(cancel)
        dlg.addAction(ok)
        
        self.present(dlg, animated: true, completion: {() -> Void in
            NSLog("대화상자가 출력된 후 호출")
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}


