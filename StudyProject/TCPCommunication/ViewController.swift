//
//  ViewController.swift
//  TCPCommunication
//
//  Created by boreum yoon on 2021/03/04.
//

import UIKit

class ViewController: UIViewController {
    
    // ip 주소와 port 번호 설정
    // let ip = "192.168.10.98"
    // let port = 9393
    let ip = "192.168.10.30"
    let port = 9999
    
    // 통신을 위한 TCPClient 프로퍼티
    var client : TCPClient?
    
    @IBOutlet weak var tfMsg: UITextField!
    @IBOutlet weak var tvMsg: UITextView!
    
    @IBAction func sendBtn(_ sender: Any) {
        
        // 접속 객체가 제대로 만들어졌는지 확인
        // nil이면 return - guard는 조건에 맞지 않으면 작업을 그만 수행하겠다는 의미
        guard let client = client else {
            return
        }
        // 서버에 연결
        switch client.connect(timeout: 30){
        case .success:
            // 성공하면 메시지 보내기
            appendToTextView(string: "연결 성공")
            if let response = sendRequest(string: "\(tfMsg.text)\n\n", using: client) {
                appendToTextView(string: "Response:\(response)")
            }
        case .failure(let error) :
            // 실패하면 메시지만 출력
            appendToTextView(string: String(describing: error))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 네트워크 접속 가능 여부를 result에 저장
        let reachability = Reachability()
        let result = reachability.isConnectedToNetwork()
        if result {
            // 네트워크가 가능 할 때 수행할 내용
            NSLog("네트워크 사용 가능")
            
            // TCPClient 생성
            client = TCPClient(address: ip, port: Int32(port))
            
        } else {
            // 네트워크 사용이 불가능할 때 수행할 내용
            NSLog("네트워크 사용 불가능")
        
        }
    }
    // 텍스트뷰 출력 메소드(3)
    private func appendToTextView(string:String) {
        tvMsg.text = tvMsg.text.appending("\n\(string)")
    }
    
    // 데이터를 읽어오는 메소드(2)
    private func readResponse(from client:TCPClient) -> String? {
        // 대기
        sleep(2)
        
        guard let response = client.read(1024*10)
        else {
            return nil
        }
        return String(bytes: response, encoding: .utf8)
    }
    
    // 데이터를 전송하는 메소드(1)
    private func sendRequest(string:String, using client:TCPClient) -> String?{
        
        // 텍스트 뷰에 메시지를 추가하는 메소드 호출
        appendToTextView(string:"Sending Message...")
        switch client.send(string: string) {
        case .success:
            return readResponse(from:client)
        case .failure(let error) :
            appendToTextView(string:String(describing:error))
            return nil
        }
    }

}
