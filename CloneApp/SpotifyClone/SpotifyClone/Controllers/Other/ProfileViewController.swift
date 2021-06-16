//
//  ProfileViewController.swift
//  SpotifyClone
//
//  Created by boreum yoon on 2021/05/31.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // updateUI에 사용할 tableView 추가
    private let tableView: UITableView = {
        let tableView = UITableView()
        // 기본적으로 숨겨지게 설정
        tableView.isHidden = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var models = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        // add Delegate, DataSource
        tableView.delegate = self
        tableView.dataSource = self
        // tableView 하위 뷰 추가
        view.addSubview(tableView)
        fetchProfile()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func fetchProfile() {
        APICaller.shared.getCurrentUserProfile { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.updateUI(with: model)
                case .failure(let error):
                    print("Profile Error: \(error.localizedDescription)")
                    self?.failedToGetProfile()
                }
            }
        }
    }
    
    private func updateUI(with model: UserProfile) {
        tableView.isHidden = false
        // configure table models - 테이블 모델 설정
        models.append("Full Name: \(model.display_name)")
        models.append("Email Address: \(model.email)")
        models.append("User ID: \(model.id)")
        models.append("Plan: \(model.product)")
         
        tableView.reloadData()
    }
    
    // 프로필이 나오지 않을 때
    private func failedToGetProfile() {
        let label = UILabel(frame: .zero)
        label.text = "프로필을 읽지 못했습니다."
        label.sizeToFit()
        label.textColor = .secondaryLabel
        view.addSubview(label)
        label.center = view.center
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row]
        // 셀이 스타일을 갖지 않게 함
        cell.selectionStyle = .none
        return cell
    }
    
    
}
