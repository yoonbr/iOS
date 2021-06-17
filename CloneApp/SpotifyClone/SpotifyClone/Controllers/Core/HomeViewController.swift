//
//  ViewController.swift
//  SpotifyClone
//
//  Created by boreum yoon on 2021/05/31.
//

import UIKit

class HomeViewController: UIViewController {
    
    // CollectionView 생성
    private var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout { SectionIndex, _ -> NSCollectionLayoutSection? in
            return HomeViewController.createSectionLayout(section: SectionIndex)
        }
    )
    
    // spinner 추가 
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.tintColor = .label
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Browse"
        view.backgroundColor = .systemBackground
        // Button Item 추가 (우측 상단 설정 버튼)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gear"),
            style: .done,
            target: self,
            action: #selector(didTapSettings)
        )
        
        configureCollectionView()
        // 만들어놓은 spinner 추가
        view.addSubview(spinner)
        fetchData()
    }
    
    // add viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    // cell 속성 추가
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(UICollectionViewListCell.self,
                                forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
    }

    // add function
    private static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
        // Item
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(1.0)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        // Group
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(120)
            ),
            subitem: item,
            count: 1)
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func fetchData() {
        // Feature Playlist
        // Recommended Tracks
        // New Releases
        APICaller.shared.getRecommendedGenres { result in
            switch result {
            case .success(let model):
                let genres = model.genres
                var seeds = Set<String>()
                while seeds.count < 5 {
                    if let random = genres.randomElement() {
                        seeds.insert(random)
                    }
                }
                
                APICaller.shared.getRecommendations(genres: seeds) {_ in
                    
                }
                
            case .failure(let error): break
            }
        }
    }
   
    
    // @objc: 각각의 변수, 함수 등에 적용하여 ObjectiveC의 접근을 가능하게 해줌
    @objc func didTapSettings() {
        let vc = SettingsViewController()
        vc.title = "Setting"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}

// add DataSource, Delegate extension
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemGreen
        return cell
    }
}
