//
//  ViewController.swift
//  navigation
//
//  Created by boreum yoon on 2021/10/29.
//

import UIKit

class ViewController: UIViewController {

    // 1. 아웃렛 선언 
    @IBOutlet var mainLB: UILabel!
    
    @IBOutlet var mainImg: UIImageView!
    
    // 10. 이미지 배열로 가져오기
    let imgs = [UIImage(named: "1.png"),
                UIImage(named: "2.png"),
                UIImage(named: "3.png"),
                UIImage(named: "4.png")]
    
    // 15. 이미지 번호 선언 
    var imgNo = 0
    
    // 4. EditC으로 prepare, 사용해서 넘어가기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let editView = segue.destination as! EditViewController
        // 11. 
        editView.dateTxt = mainLB.text!
        // 16. 이미지 번호 넘기기 
        editView.imgNo = imgNo
        // 6. editController의 maincon 변수를 self로 연동 
        editView.mainCon = self
    }
}
