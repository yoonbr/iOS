//
//  ViewController.swift
//  SyncDownload
//
//  Created by boreum yoon on 2021/03/04.
//

import UIKit

class ViewController: UIViewController {
    
    var imageView:UIImageView!
    var textView:UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 뷰 생성
        textView = UITextView(frame: CGRect(x: 0, y: 300, width: 320, height: 300))
        // 다운로드 받을 URL을 생성
        let google = URL(string: "https://www.google.com")
        // 데이터 가져오기 - try!는 예외가 발생하지 않는다고 알려주고
        // 예외처리를 하지 않겠다는 의미
        let googleData = try! Data(contentsOf: google!)
        // 문자열로 변환
        let googleText = String(data: googleData, encoding: .utf8)
        // 출력
        textView.text = googleText
        // 텍스트뷰 배치
        self.view.addSubview(textView)
        
        // 이미지를 다운로드 받아서 출력
        
        // 화면 전체 영역에 대한 구조체 가져오기
        let frame:CGRect = UIScreen.main.bounds
        // 이미지 뷰 생성
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 250, height:350))
        let imageUrl = URL(string: "https://dbscthumb-phinf.pstatic.net/3165_000_4/20170929033047479_886EAJ6R5.jpg/W0159548.jpg?type=m250&wm=N")
        // 데이터 가져오기
        let imageData = try! Data(contentsOf: imageUrl!)
        // 이미지로 변환
        let image = UIImage(data: imageData)
        // 출력
        imageView.image = image
        // 이미지 뷰 배치
        self.view.addSubview(imageView)
        
        
    }
}

