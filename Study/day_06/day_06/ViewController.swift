//
//  ViewController.swift
//  day_06
//
//  Created by boreum yoon on 2021/10/20.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    // 1. 텍스트필드, 웹킷뷰 아웃렛 선언
    @IBOutlet var urlText: UITextField!
    
    @IBOutlet var myWeb: WKWebView!
    
    @IBOutlet var myActivityIndicator: UIActivityIndicatorView!
    
    var newAddr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 7. WKNavigationDelegate 추가
        myWeb.navigationDelegate = self
        
        // 3. webView 미리 불러오기 (https://www.apple.com)
        /*
        // 메소드로 만들어서 빼는게 편함
        let addr = "https://www.apple.com"
        
        // url request 형태로 가져오기
        let url = URL(string: addr)!
        let req = URLRequest(url: url)
        myWeb.load(req)
        
        // myWeb.load(URLRequest(url: URL(string: addr)!))
        
        // text도 설정한 url 주소를 가지고 오기
        urlText.text = addr
         */
        
        // 4-1. 함수 선언(매개변수)
        goToWeb("https://www.apple.com")
        
    }
    
    // 7-1. 로딩 중일 때 인디케이터를 실행, 화면에 나타나게 함
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        myActivityIndicator.startAnimating()
        myActivityIndicator.isHidden = false
    }
    
    // 7-2. 로딩이 완료되었을 때 동작 - 인디케이터 중지, 숨김
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        myActivityIndicator.stopAnimating()
        myActivityIndicator.isHidden = true
    }
    
    // 7-3. 로딩이 실패했을 때 동작 - 인디케이터 중지, 숨김
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        myActivityIndicator.stopAnimating()
        myActivityIndicator.isHidden = true
    }
    
    // 4. 3번의 메소드를 빼서 함수로 선언
    func goToWeb(_ addr:String) {
        
        let url = URL(string: addr)!
        let req = URLRequest(url: url)
        myWeb.load(req)
        
        urlText.text = addr
        
    }
    
    // 2. 1번 제외한 모든 버튼 액션으로 선언
    // 5. go, naver, google, string, file 에 해당하는 액션 선언
    @IBAction func goBtn(_ sender: UIButton) {
        // url text에 대한 내용을 가져오기 - 검색창이 아닌 브라우저 이므로 url을 정확히 입력해야 함
        goToWeb(urlText.text!)
    }
    
    @IBAction func naverBtn(_ sender: UIButton) {
        goToWeb("https://m.naver.com")
    }
    
    @IBAction func googleBtn(_ sender: UIButton) {
        goToWeb("https://www.google.com")
    }
    
    @IBAction func strBtn(_ sender: UIButton) {
        
        // html 코드를 직접 열기
        let tt = "<html><head><meta charset='UTF-8'>" +
            "<title>Node Server</title></head>" +
            "<body><h1>PortFolio</h1>" +
            "<a href='https://www.apple.com'> apple페이지로 이동 </a><br/>" +
            "<a href='wine/insert'>insert wine</a><br/>" +
            "<a href='note/viewall'>노트 전체 리스트</a><br/>" +
            "<a href='member/register'>회원가입</a><br />" +
            "<div id='logindisp'>" +
            "</div></body></html>"
        
        myWeb.loadHTMLString(tt, baseURL: nil)
        urlText.text = "String"
        
    }
    
    @IBAction func fileBtn(_ sender: UIButton) {
        // file load
        // 파일 경로 가져오기 - Bundle 이미지파일 로드시 많이 사용
        let fPath = Bundle.main.path(forResource: "test", ofType: "html")
        // optional - fPath의 값이 없거나 못 가져올 수 있으므로
        let url = URL(fileURLWithPath: fPath!)
        
        let req = URLRequest(url: url)
        myWeb.load(req)
        urlText.text = "File"
    }

    // 6. 웹 실행시 작동하는 버튼 작업 생성 (정지, 새로고침, 뒤로, 앞으로)
    @IBAction func stopBtn(_ sender: UIBarButtonItem) {
        myWeb.stopLoading()
    }
    
    @IBAction func refreshBtn(_ sender: UIBarButtonItem) {
        myWeb.reload()
    }
    
    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        myWeb.goBack()
        // 주소창도 같이 변경해줘야함 - 문자열 변환 \(), 옵셔널 넣기
        urlText.text = "\(myWeb.url!)"
    }
    
    @IBAction func nextBtn(_ sender: UIBarButtonItem) {
        myWeb.goForward()
        urlText.text = "\(myWeb.url!)"
    }
}
