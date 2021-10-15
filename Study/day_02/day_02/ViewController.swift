//
//  ViewController.swift
//  day_02
//
//  Created by boreum yoon on 2021/10/08.
//

import UIKit

class ViewController: UIViewController {
    //
    var imgNum = 0
    var maxNum = 6
    
    // 이미지뷰 아웃렛 변수 생성
    @IBOutlet var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // 버튼 누를 때 마다 이미지 변경할 메소드 생성
    @IBAction func btn01(_ sender: UIButton) {
        // imgView.image = UIImage(named: "wine01.png")
        print("wine" + (sender.titleLabel?.text)! + ".png")
        imgView.image = UIImage(named: "wine" + (sender.titleLabel?.text)! + ".png")
        
    }

    // 다음 버튼을 클릭하면 나올 수 있게 만들어줌
    @IBAction func nextBtn(_ sender: UIButton) {
        // 이미지 번호보다 1씩 더해서 나타내기
        imgNum = imgNum + 1
        
        // 이미지의 번호가 최대 이미지 번호보다 커지면
        // 다시 1번으로 돌아감
        if imgNum > maxNum {
            imgNum = 1
        }
    
        let imgName = String(imgNum) + ".png"
        imgView.image = UIImage(named: imgName)
    }
    
    
    @IBAction func prevBtn(_ sender: UIButton) {
        // 이미지 번호보다 1씩 빼기
        imgNum = imgNum - 1
        
        // 이미지의 번호가 1보다 작아지면
        // 이미지는 최대 번호의 이미지(6)를 나타냄
        if imgNum < 1 {
            imgNum = maxNum
        }
        
        let imgName = String(imgNum) + ".png"
        imgView.image = UIImage(named: imgName)
    }
}

