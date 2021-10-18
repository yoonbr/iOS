//
//  ViewController.swift
//  dualTT
//
//  Created by boreum yoon on 2021/10/15.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var selectLB: UILabel!
    
    @IBOutlet var myImg: UIImageView!
    
    // 5. 이미지 멤버 배열 선언
    let images = ["wine01.png","wine02.png","wine03.png","wine04.png","wine05.png",
                  "wine06.png","wine07.png","wine08.png","wine09.png","wine10.png"]
    
    let images3 = ["Red", "White"]
    
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2 
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return images.count/2
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    
            // UIImage를 imageView로 변환
            let img = UIImageView(image: images2[row])
    
            // 이미지 사이즈 변경
            img.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
    
            // imageView 리턴
            return img
        }

    
}


/*
 import UIKit

 class ViewController: UIViewController, UIPickerViewDelegate,
     UIPickerViewDataSource{

 let imgs = ["asd.jpg","cvb.jpg","klj.jpg","oiu.jpg",
 "qqq.jpg","qwe.jpg","son_1.JPG",
 "son_3.JPG"]

 let imgs2 = [
 UIImage(named:"asd.jpg"),
 UIImage(named:"cvb.jpg"),
 UIImage(named:"klj.jpg"),
 UIImage(named:"oiu.jpg"),
 UIImage(named:"qqq.jpg"),
 UIImage(named:"qwe.jpg"),
 UIImage(named:"son_1.JPG"),
 UIImage(named:"son_3.JPG")]

 //pickerView의 열 갯수
 func numberOfComponents(in pickerView: UIPickerView) -> Int {
 return 2
 }

 //pickerView의 행 갯수
 func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
     return imgs.count / 2
 }
     
     // 항목 설정 -> 이미지뷰
     func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
         
         let res = UIImageView(image: imgs2[component*4 + row])
         
         res.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
         
         return res
     }
     
     // 행 1개의 높이
     func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
         return 150
     }
     
     //항목 선택 이벤트
     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         //print("항목 선택 \(row)")
         if component == 0 {
             seLB.text = "선택 : \( imgs[row] )"
         }else {
             mmm.image = imgs2[4+row]
         }
     }

     @IBOutlet var seLB: UILabel!
     
     
     @IBOutlet var mmm: UIImageView!
     
     override func viewDidLoad() {
         super.viewDidLoad()
         // Do any additional setup after loading the view.
     }


 }

**/
