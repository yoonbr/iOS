//
//  ViewController.swift
//  ImageViewAnimation
//
//  Created by boreum yoon on 2021/02/24.
//

import UIKit

class ViewController: UIViewController {
    
    // 이벤트 연결
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblPage: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    // UIImage 배열 생성
    var imgArray = [UIImage]()
    // 이미지 인덱스를 저장할 변수 생성
    var i:Int?
    // 애니메이션 속도
    var speed:Float?
    
    // 뷰 컨트롤러가 생성되고 뷰를 메모리 할당한 호출되는 메소드
    // 출력은 아직 안되고, 출력 전 초기화 작업을 진행
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // img 파일을 이용해서 UIImage를 만들어서 imgArray에 추가
        // 이름이 규칙적이면 반복문 사용 가능
        for idx in 0...4 {
            imgArray.append(UIImage(named: "red\(idx).png")!)
        }
        
        // 이미지 뷰의 애니메이션 이미지 설정
        imgView.animationImages = imgArray
        // 현재 출력 중인 이미지 인덱스 설정
        i = 0
        imgView.image = imgArray[0]
        lblPage.text = "\(i!+1)/\(imgArray.count)"
        speed = 0.5
    }

    // 메소드 연결
    // slider의 값이 변경되었을 때 (valueChanged)
    @IBAction func changedSpeed(_ sender: Any) {
        speed = slider.value
        
        if imgView.isAnimating {
            imgView.stopAnimating()
            // 애니메이션 속도 설정
            // 속도 설정
            speed = speed! * 5.0
            imgView.animationDuration =
                TimeInterval(Int(speed!) *
                imgArray.count)
            
            imgView.startAnimating()
        }
    }
    
    // 버튼을 눌렀을 때 (touchUpInside)
    @IBAction func prev(_ sender: Any) {
        i = i! - 1
        if i! < 0 {
            i = imgArray.count - 1
        }
        imgView.image = imgArray[i!]
        lblPage.text = "\(i!+1)/\(imgArray.count)"
    }
    
    // 이벤트 처리에서 (_ sender: 는 이벤트가 발생한 객체
    @IBAction func play(_ sender: Any) {
        // toggle 생성
        if imgView.isAnimating == false {
            // 속도 설정
            speed = speed! * 5.0
            imgView.animationDuration =
                TimeInterval(Int(speed!) *
                imgArray.count)
            
            imgView.startAnimating()
            // button text 변경
            (sender as! UIButton).setTitle("Stop", for: .normal)
            
        } else {
            imgView.stopAnimating()
            (sender as! UIButton).setTitle("Start", for: .normal)
        }
    }
    
    @IBAction func next(_ sender: Any) {
        i = i! + 1
        if i! >= imgArray.count {
            i = 0
        }
        imgView.image = imgArray[i!]
        lblPage.text = "\(i!+1)/\(imgArray.count)"
    }
    
}

