//
//  ViewController.swift
//  PickerSample
//
//  Created by boreum yoon on 2021/02/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var pickerImage: UIPickerView!
    @IBOutlet weak var lblImageName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    // UIImage 배열 - 인스턴스 배열까지 수행
    var imageArray:[UIImage?]? = nil
    
    // 실제 데이터까지 초기화
    var imageFileName : [String]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageArray = [UIImage?]()
        imageFileName = ["jerry1.jpeg","jerry2.jpeg","jerry3.jpeg","jerry4.jpeg","jerry5.jpeg"]
        
        // 기존에 저장되어있는 이미지를 부를땐 named:
        // 이미지 파일이름을 이용해서 UIImage를 생성하고 배열에 추가
        for i in 0..<imageFileName!.count {
            let image = UIImage(named: imageFileName![i])
            imageArray?.append(image)
        }
        // 레이블에 첫번째 이미지 이름을 출력
        lblImageName.text = imageFileName![0]
        // 첫번째 이미지를 이미지뷰에 출력
        imageView.image = imageArray![0]
        
        // PickerView의 출력과 이벤트 처리에 관련된
        // 메소드의 위치를 설정
        pickerImage.delegate = self
        pickerImage.dataSource = self
        
        
    }
    
    // 이미지 밖 화면을 누르면 초기화 됨
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // 랜덤 출력
        // 0 ~ 20000 사이의 랜덤한 정수 추출
        let random1 = arc4random_uniform(20000)
        let random2 = arc4random_uniform(20000)
        let random3 = arc4random_uniform(20000)
        
        // 피커뷰의 선택을 변경
        pickerImage.selectRow(20000 + Int(random1), inComponent: 0, animated: true)
        pickerImage.selectRow(20000 + Int(random2), inComponent: 1, animated: true)
        pickerImage.selectRow(20000 + Int(random3), inComponent: 2, animated: true)
        
        // 선택된 데이터 확인
        NSLog("1번열:\(20000 + Int(random1))")
        NSLog("2번열:\(20000 + Int(random2))")
        NSLog("3번열:\(20000 + Int(random3))")
    }
}

// PickerView 출력과 이벤트 처리를 위한 extension
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    // 열의 개수를 설정하는 메소드
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    // 각 열 별로 행의 개수를 설정하는 메소드 - int 리턴
    // component가 열 번호 numberOfComponents의 값에 따라 달라짐
    // 1이면 0, 2면 0,1, 3이면 0,1,2
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageFileName!.count * 10000
    }
    
    /*
    // 문자열 리턴 메소드 - string 리턴
    // component가 열번호, row가 행번호
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return imageFileName![row]
    }
    */
    
    // 행의 높이를 설정해주는 메소드 - rowHeight
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100
    }
    
    // pickerView에 View를 출력하는 메소드 - UIView
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imageView = UIImageView(image: imageArray![row % imageFileName!.count])
        imageView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        return imageView
    }
    
    // pickerView의 선택이 변경될 때 호출되는 메소드
    func pickerView(_ pickerView: UIPickerView,
                didSelectRow row: Int,
                inComponent component: Int){
        // 선택한 행 번호의 데이터를 출력
        lblImageName.text = imageFileName![row % imageFileName!.count]
        imageView.image = imageArray![row % imageFileName!.count]
        
    }
}

