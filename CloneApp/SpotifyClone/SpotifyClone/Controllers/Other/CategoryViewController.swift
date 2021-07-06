//
//  CategoryViewController.swift
//  SpotifyClone
//
//  Created by boreum yoon on 2021/07/06.
//

import UIKit

class CategoryViewController: UIViewController {
    let category: Category
    
    init(category: Category) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private var playlists = [Playlist]()
    
    // MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = category.name
        
        APICaller.shared.getCategoryPlaylists(category: category) { result in
            switch result {
            case .success(let playlists):
                self?.playlists = playlists
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

}
