//
//  ViewController.swift
//  GestureTest
//
//  Created by boreum yoon on 2021/02/24.
//

import UIKit

class ViewController: UIViewController {
    // 이전 확대 축소 비율을 저장할 프로퍼티
    var oldScale : CGFloat = 1.0
    
    // 핀치가 사용할 메소드
    @objc func pinchGestureMethod(sender:UIPinchGestureRecognizer) {
        // 현재 거리를 가져옴
        let newScale = sender.scale
        // 멀어짐 => 확대
        if newScale > 1.0 {
            imgView.transform = CGAffineTransform(scaleX: oldScale + newScale - 1, y: oldScale + newScale - 1)
        } else {
            imgView.transform = CGAffineTransform(scaleX: oldScale * newScale, y: oldScale * newScale)
        }
        // 확대 축소 배열을 저장
        if sender.state == UIGestureRecognizer.State.ended{
            if newScale > 1 {
                oldScale = oldScale + newScale + 1
            } else {
                oldScale = oldScale * newScale
            }
        }
    }

    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 이미지 뷰가 터치를 사용할 수 있도록 설정
        imgView.isUserInteractionEnabled = true
        
        // 탭 제스쳐 생성
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGestureMethod(sender:)))
        
        // 두 손가락으로 터치 할 때만 반응
        tap.numberOfTouchesRequired = 2
        
        // imgView에 탭 제스쳐 연결
        imgView.addGestureRecognizer(tap)
        
        // 핀치 제스처 생성
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureMethod(sender:)))
        
        imgView.addGestureRecognizer(pinch)
    }
    
    
    // 탭 제스쳐가 호출할 메소드
    @objc func tapGestureMethod(sender:UITapGestureRecognizer) {
        NSLog("이미지 뷰에서 tap")
    }

}

