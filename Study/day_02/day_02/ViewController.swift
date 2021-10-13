//
//  ViewController.swift
//  day_02
//
//  Created by boreum yoon on 2021/10/08.
//

import UIKit

class ViewController: UIViewController {
    
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

}

