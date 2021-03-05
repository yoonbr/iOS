//
//  ViewController.swift
//  MovieInformation
//
//  Created by boreum yoon on 2021/03/05.
//

import UIKit

import Alamofire

class ViewController: UIViewController {
    
    // 텍스트와 이미지를 출력할 View 프로퍼티
    var imageView:UIImageView!
    var imageName:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 화면 전체 크기를 사용하기 위해서 화면 전체 정보를 가져오기
        let frame = UIScreen.main.bounds
        
        // 이미지 뷰를 만들고 이미지 뷰를 배치
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
        imageView.center = CGPoint(x: frame.width/2, y: frame.height/2)
        self.view.addSubview(imageView)
        
        // 레이블을 만들고 레이블을 배치
        imageName = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        imageName.center = CGPoint(x: imageView.center.x, y: imageView.center.y + 200)
        imageName.text = "Sanrio Amiibo"
        imageName.textAlignment = .center
        self.view.addSubview(imageName)
        
        // 동기식으로 이미지를 다운로드 받아서 출력
        let addr = "https://cgeimage.commutil.kr/phpwas/restmb_allidxmake.php?idx=3&simg=20210226134334014999f2741072510624586229.jpg"
        let imageUrl = URL(string: addr)
        
        /*
        let imageData = try! Data(contentsOf: imageUrl!)
        let image = UIImage(data: imageData)
        imageView.image = image
        */
        
        /*
        // 스레드를 이용해서 다운로드 받도록 수정
        let imageDownThread = ImageDownThread()
        imageDownThread.url = imageUrl
        imageDownThread.imageView = imageView

        // 스레드 시작
        imageDownThread.start()
         */

        // URLSession과 URLSessionTask를 이용한 이미지 다운로드
        // 세션 생성
        let session = URLSession.shared
        // 작업 생성
        let task = session.dataTask(with: imageUrl!, completionHandler: {(data: Data?, response:URLResponse?, error:Error?)-> Void in

            // 에러가 발생하면 발생할 동작
            if error != nil {
                NSLog("다운로드 에러 : \(error!.localizedDescription)")
                return
            }
            // 정상적으로 동장할 때 발생될 동작
            // 이미지 뷰에 받은 이미지 출력
            OperationQueue.main.addOperation {
                self.imageView.image = UIImage(data: data!)
            }
        })

        // 작업 실행
        task.resume()
        
        /*
        // 데이터를 비동기적으로 다운로드 받기
        let request = AF.request("https://httpbin.org/get", method:.get, parameters:nil)
        request.response {
            response in
            let msg = String(data: response.data!, encoding: .utf8)
            NSLog(msg!)
        }
        */
        
        
        /*
        // 문자열 가져오기
        let request = AF.request("https://www.daum.net", method: .get, parameters: nil)
        request.responseString(completionHandler: {response in NSLog(response.value!)})
        */
        
        /*
        // Kakao Open API 가져오기
        // URL 생성 ("자바" 는 여기에 쓰지않음 - parameter이 있을 때는 인코딩)
        let address = "https://dapi.kakao.com/v3/](https://dapi.kakao.com/v3/)search/book?target=title&query="
        let queryString = "자바".addingPercentEncoding(withAllowedCharacters: .urlUserAllowed)
        let kakaoUrl = "\(address)\(queryString!)"
        let request = AF.request(kakaoUrl, method: .get, encoding: JSONEncoding.default, headers: ["Authorization":"KakaoAK 06fab290c9f4eb6f130c09796d57bc30"])
        request.responseJSON{
            response in
            let jsonObject = response.value as? [String:Any]
            // NSLog("\(jsonObject!)")
            let documents = jsonObject!["documents"] as! NSArray
            for index in 0 ... (documents.count - 1){
                let item = documents[index] as! NSDictionary
                NSLog("\(item["title"]!)")
            }
        }
        */
        
        // 업로드 할 이미지 데이터를 생성
        let image1 = UIImage(named:"check.png")
        let imageData = image1!.pngData()
            // image1!.jpegData(compressionQuality: 0.50)
        
        AF.upload(multipartFormData: {multipartFormData in
            multipartFormData.append(Data("Check".utf8), withName: "itemname")
            multipartFormData.append(Data("98000".utf8), withName: "price")
            multipartFormData.append(Data("ItemCheck".utf8), withName: "description")
            multipartFormData.append(Data("2021-01-01".utf8), withName: "updatedate")
            multipartFormData.append(imageData!, withName: "pictureurl", fileName: "updateFormat.png", mimeType: "image/png") /// 확장자에 맞추어 변경
        }, to: "http://cyberadam.cafe24.com/item/insert").responseJSON{response in
            if let jsonObject = response.value as? [String:Any]{
                let result = jsonObject["result"] as! Int
                NSLog("\(result)")
            }
        }
    }
}

// 이미지를 다운로드 받아 출력하는 스레드
class ImageDownThread : Thread{
    // override main
    var imageView : UIImageView!
    var url : URL!
    override func main(){
        let imageData = try!Data(contentsOf: url)
        let image = UIImage(data: imageData)
        // imageView.image = image /// 실행하면 이 부분에서 예외 발생
        
        // Main Thread 에서 이미지를 출력하도록 수정
        OperationQueue.main.addOperation {
            self.imageView.image = image
        }
    }
}


