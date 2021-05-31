//
//  TabBarViewController.swift
//  SpotifyClone
//
//  Created by boreum yoon on 2021/05/31.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // tabBarContoller에 사용될 하단 Controller 추가
        let vc1 = HomeViewController()
        let vc2 = SearchViewController()
        let vc3 = LibraryViewController()
        
        vc1.title = "Browse"
        vc2.title = "Search"
        vc3.title = "Library"
        
        // 타이틀 크기를 항상 크게
        vc1.navigationItem.largeTitleDisplayMode = .always
        vc2.navigationItem.largeTitleDisplayMode = .always
        vc3.navigationItem.largeTitleDisplayMode = .always

        // 선택하면 이동되어질 ViewController 설정
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        
        // TabBar 아이콘 추가
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "music.note.house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "music.note.list"), tag: 3)
    
        // title 크게 표시하게 설정
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.prefersLargeTitles = true
        
        // animated : false - 애니메이션 없이 뷰컨 교체
        setViewControllers([nav1, nav2, nav3], animated: false)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
