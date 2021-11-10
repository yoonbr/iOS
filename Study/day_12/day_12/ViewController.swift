//
//  ViewController.swift
//  day_12
//
//  Created by boreum yoon on 2021/11/10.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var myImg: UIImageView!
    
    // 1. delegate self
    let imgPP = UIImagePickerController()
    
    // 2-2. 저장관련 변수 설정
    // 이미지 저장 유무
    var imgSave = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1-1. delegate 선언
        imgPP.delegate = self
        
        // 1-4. 파일의 타입 바꾸기 (iOS 버전 따라서 명령어가 달라짐)
        imgPP.mediaTypes = [kUTTypeImage as String]
    }
    
    // 사진 촬영
    @IBAction func captureGo(_ sender: UIButton) {
        
        imgSave = true // 이미지 저장 설정
        
        // 1-2. 카메라 앱 설정 - imgPP의 sourceType은 camera로 부터 얻어옴
        imgPP.sourceType = .camera
        
        // 1-3. 앱 열기(present)
        present(imgPP, animated: true, completion: nil)
    
    }
    
    // 1-4. 카메라를 열고 찍은 후 use Photo를 선택하면 돌아온 후의 작업
    // 카메라나 사진 앨범 앱 사용 후 자동 실행
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("imagePickerController() 자동실행")
        
        // 1-6. 촬영한 이미지 가져오기 - info
        let currImg = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
    
        // 1-7. 사진을 찍고 use photo를 진행하면 imageView에 띄워주는 기능 - currImg
        // 선언한 currImg를 imageView에 넣기
        myImg.image = currImg
        
        // 저장 설정 imgSave가 true 일 때만 저장(사진 촬영)
        if imgSave { // 1-8. 촬영한 이미지(currImg) 사진 갤러리에 저장 - 저장 권한 설정 창 나옴
            UIImageWriteToSavedPhotosAlbum(currImg, self, nil, nil)
        }
        
        // 1-5. use photo 창 닫기 (completion - 이후에 하는 작업)
        // 현재 앱 제거
        self.dismiss(animated: true, completion: nil)
        
    }
    
    // 앨범 열기
    @IBAction func loadImgGo(_ sender: UIButton) {
        
        // 이미지 저장 안함으로 설정
        imgSave = false
        
        // 2. 사진 앨범 설정
        imgPP.sourceType = .photoLibrary
        
        // 2-1. 사진앨범 앱 열기 - 앱에서 사진을 선택 후 이미지뷰에 띄우면 사진이 다시 하나 더 저장 됨
        // -> 변수를 생성하여 촬영하는 건지, 앨범인지 확인 후 저장하게 끔 설정하기 (imgSave)
        present(imgPP, animated: true, completion: nil)
        
    }
}


// 카메라로 부터 얻을 수 있는 파일의 종류
// 카메라에서 돌아왔을 때의 작업은 다른 함수를 이용 - delegate 사용 이유

// 사진 찍고 저장
