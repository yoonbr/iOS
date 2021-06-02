//
//  AuthViewController.swift
//  SpotifyClone
//
//  Created by boreum yoon on 2021/05/31.
//

import UIKit
import WebKit

class AuthViewController: UIViewController, WKNavigationDelegate {

    private let webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        // web content에서 javaScript 사용 여부
        prefs.allowsContentJavaScript = true
        // WKWebViewConfiguration : 웹 보기 초기값 구성
        let config = WKWebViewConfiguration()
        // 콘텐츠를 로드 및 렌더링할 때 사용할 기본 설정
        config.defaultWebpagePreferences = prefs
        
        // WKWebView : 웹 뷰를 작성하고 지정된 프레임 및 구성 데이터로 초기화
        let webView = WKWebView(frame: .zero, configuration: config)
        
        return webView
    }()
    
    // Handler 추가 : 작업 실행 처리
    public var completionHandler: ((Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign In"
        view.backgroundColor = .systemBackground
        webView.navigationDelegate = self
        view.addSubview(webView)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
   
}
