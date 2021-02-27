//
//  ViewController.swift
//  ImageSwipe
//
//  Created by boreum yoon on 2021/02/24.
//

import UIKit

class ViewController: UIViewController {
    
    // 스크롤 뷰
    var scrollView:UIScrollView?
    // 스크롤 뷰에 출력할 컨텐츠 뷰
    var contentView:UIView?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 적절한 크기로 ScrollView 생성
        scrollView = UIScrollView(frame: CGRect(x: 60, y: 20, width: 400, height: 400))
        // 내용이 되는 뷰를 생성 (꽉차게)
        contentView = UIView(frame: CGRect(x: 0, y: 0, width: 400*5, height: 400))
        
        // x 좌표를 저장할 변수
        var total:Int = 0
        for i in 1...5 {
            // 이미지 뷰를 x 좌표 방향으로 400씩 옮기면서 생성
            let imageView = UIImageView(frame: CGRect(x: total, y: 0, width: 400, height: 400))
            let image = UIImage(named: "jerry\(i).jpeg")
            imageView.image = image!
            
            total = total + 400
            
            // contentView에 추가
            contentView?.addSubview(imageView)
        }
        // contentView를 스크롤 뷰에 추가
        scrollView?.addSubview(contentView!)
        scrollView!.contentSize = contentView!.frame.size
        
        // 스크롤 뷰를 페이지 단위로만 스크롤 할 수 있도록 설정
        scrollView!.isPagingEnabled = true
        
        
        // 스크롤 뷰를 현재 뷰 위에 배치
        self.view.addSubview(scrollView!)
    }


}

