//
//  ViewController.swift
//  SpotifyClone
//
//  Created by boreum yoon on 2021/05/31.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .systemBackground
        // Button Item 추가 (우측 상단 설정 버튼)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettings))
    }
    
    // @objc: 각각의 변수, 함수 등에 적용하여 ObjectiveC의 접근을 가능하게 해줌
    @objc func didTapSettings() {
        let vc = SettingsViewController()
        vc.title = "Setting"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}

