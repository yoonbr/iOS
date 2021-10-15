//
//  ViewController.swift
//  day_04
//
//  Created by boreum yoon on 2021/10/15.
//

import UIKit

// 2. 프로토콜 선언 (UIPickerViewDelegate,UIPickerViewDataSource)
class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // 5. 이미지 멤버 배열 선언
    let images = ["wine01.png","wine02.png","wine03.png","wine04.png","wine05.png",
                  "wine06.png","wine07.png","wine08.png","wine09.png","wine10.png"]
    
    // 7. UIImage 변수 선언
    // let images2 =  ["wine01.png","wine02.png","wine03.png","wine04.png","wine05.png",                "wine06.png","wine07.png","wine08.png","wine09.png","wine10.png"]
    
    let images2 = [
        UIImage(named: "wine01.png"),
        UIImage(named: "wine02.png"),
        UIImage(named: "wine03.png"),
        UIImage(named: "wine04.png"),
        UIImage(named: "wine05.png"),
        UIImage(named: "wine06.png"),
        UIImage(named: "wine07.png"),
        UIImage(named: "wine08.png"),
        UIImage(named: "wine09.png"),
        UIImage(named: "wine10.png")
    ]
    
    
    // 3. method overriding
    // pickerView의 열 갯수
    func numberOfComponents(in pickerView: UIPickerView) -> Int { // int return
        return 1
    }
    
    // pickerView의 행 갯수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { // int return
        return images.count
    }
    
//    // 4. pickerView 함수 생성 / 항목 설정 -> 문자열
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        // return "Wine 열 : \(component), 행: \(row)"
//        return images[row]
//    }
    
    // return 값이 UIView인 함수를 생성
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        // UIImage를 imageView로 변환
        let img = UIImageView(image: images2[row])
        
        // 이미지 사이즈 변경
        img.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
        
        // imageView 리턴
        return img
    }
    
    // 행의 높이 조절
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 150
    }
    
  
    
    // 6. 선택된 값을 나타내는 함수 - didSelectRow
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 선택 열 출력 test
        // print("항목 선택: \(row)")
        
        // selectLB에 출력할 수 있게
        selectLB.text = "항목 선택: \(images[row])"
        
        // myImage.image = UIImage(named: images[row])
        // 8. 이미지 출력
        myImage.image = images2[row]
    }

    // 1. 레이블, 이미지 뷰 아웃렛 변수 선언
    @IBOutlet var selectLB: UILabel!
    
    @IBOutlet var myImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}

