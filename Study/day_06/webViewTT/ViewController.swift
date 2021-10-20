//
//  ViewController.swift
//  webViewTT
//
//  Created by boreum yoon on 2021/10/20.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet var myWeb: WKWebView!
    
    @IBOutlet var urlText: UITextField!
    
    let urls = [
        "https://www.apple.com/",
        "https://m.naver.com",
        "https://www.google.com",
        "https://m.daum.com",
        "https://m.nate.com"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func goToWeb(_ addr:String) {
        
        let url = URL(string: addr)!
        let req = URLRequest(url: url)
        myWeb.load(req)
        urlText.text = addr
        
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return urls.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return urls[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        goToWeb("\(urls[row])")
    }
}
