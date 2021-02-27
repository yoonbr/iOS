//
//  ViewController.swift
//  ControlTest
//
//  Created by boreum yoon on 2021/02/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var lblDisp: UILabel!
    @IBOutlet weak var txtAge: UITextField!
    
   
    @objc func
    keyboardShow(notification:Notification) {
        // 버튼의 위치와 크기를 가져옴
        let frame = button.frame
        // y 좌표만 50을 빼기
        let moveFrame = CGRect(x: frame.origin.x, y: frame.origin.y-50, width: frame.width, height: frame.height)
        // 버튼에 적용
        button.frame = moveFrame
    }
    
    @objc func
    keyboardHide(notification:Notification) {
        // 버튼의 위치와 크기를 가져옴
        let frame = button.frame
        // y좌표만 50을 더하기
        let moveFrame = CGRect(x: frame.origin.x, y: frame.origin.y+50, width: frame.width, height: frame.height)
        // 버튼에 적용
        button.frame = moveFrame
    }
    
    
    @IBAction func click(_ sender: Any) {
        // 로그 출력
        // NSLog("Click Button")
        
        let name = txtName.text
        let age = txtAge.text

        lblDisp.text = "\(name!):\(age!)"

        txtName.text = ""
        txtAge.text = ""
        
    }
    
    // 터치 관련 메소드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        txtName.resignFirstResponder()
        txtAge.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // 처음부터 키보드가 보이도록 하기
        txtName.becomeFirstResponder()
        
        // 텍스트 필드의 delegate 설정
        txtName.delegate = self
        
        // 타이머 생성 - selector 연결
        // target - 메소드를 소유
        /*
        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerProc), userInfo: nil, repeats: true)
        */
        
        // 타이머 생성 - block 연결, closure 을 이용한 타이머 생성
        // {이름:자료형} -> 리턴타입 inblock (timer:Timer) -> Void in 뒤에 타이머가 수행 할 함수를 작성
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {
            (timer:Timer) -> Void in
            // 타이머가 수행할 함수
            // 현재 시간을 문자열로 만들어서 label에 출력
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd ccc hh:mm:ss"
            let msg = formatter.string(from: Date())
            // 레이블에 출력
            // Closure 에서는 class에 property를 사용할 때
            // Self.를 붙여야 사용 가능
            self.label.text = msg
        })
        
        // 레이블의 속성을 수정
        label.textColor = UIColor.gray
        // 경계선 두께와 색상 설정
        label.layer.borderWidth = 5.0
        label.layer.borderColor = UIColor.blue.cgColor
      
        // 이미지 파일을 UIImage 객체로 변환
        let image1:UIImage! = UIImage(named: "btn1.png")
        let image2:UIImage! = UIImage(named: "btn2.png")
        
        // 버튼에 이미지 설정
        button.setBackgroundImage(image1, for: .normal)
        button.setBackgroundImage(image2, for: .highlighted)
    
        // 버튼의 타이틀 설정
        button.setTitle("보통", for: .normal)
        button.setTitle("누름", for: .highlighted)
        
    }
    
    // 타이머가 수행할 함수
    // selecter에 연결할때 이렇게 생성 
    @objc func timerProc(timer:Timer) {
        // 현재 시간을 문자열로 만들어서 label에 출력
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd ccc hh:mm:ss"
        let msg = formatter.string(from: Date())
        // 레이블에 출력
        label.text = msg
    }
    
   
    // 첫번째 텍스트 필드에서 return 키를 눌렀을 때 호출되는 메소드
    @IBAction func hiddenKeyboard(_ sender: Any) {
        txtName.resignFirstResponder()
    }
}

// 클래스 확장 생성
extension ViewController : UITextFieldDelegate {
    // return 키를 눌렀을 때 호출되는 메소드를 생성
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}



