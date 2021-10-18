//
//  LibraryPlaylistViewController.swift
//  SpotifyClone
//
//  Created by boreum yoon on 2021/09/04.
//

import UIKit

class LibraryPlaylistViewController: UIViewController {
    
    var playlists = [Playlist]()
    
    private let noPlaylistsView = ActionLabelView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // 함수 실행
        setUpNoPlaylistsView()
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noPlaylistsView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        noPlaylistsView.center = view.center
    }
    
    // viewDidLoad에서 빠져나옴
    private func setUpNoPlaylistsView() {
        view.addSubview(noPlaylistsView)
        noPlaylistsView.delegate = self
        // 플레이리스트가 없을 경우 Create 버튼을 클릭해서 만들 수 있도록 진행 - 함수 지정
        noPlaylistsView.configure(
            with: ActionLabelViewViewModel(
                text: "You don't have any playlists yet.", actionTitle: "Create"
            )
        )
    }
    
    // viewDidLoad에서 빠져나옴
    private func fetchData() {
        APICaller.shared.getCurrentUserPlaylists { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let playlists):
                    self?.playlists = playlists
                    self?.updateUI()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
     
    private func updateUI() {
        if playlists.isEmpty {
            // Show label
            noPlaylistsView.isHidden = false
        }
        else {
            // Show table
            noPlaylistsView.isHidden = true
            
        }
    }
}

extension LibraryPlaylistViewController: ActionLabelViewDelegate {
    
    // Show creation UI
    func actionLabelViewDidTapButton(_ actionView: ActionLabelView) {
        let alert = UIAlertController (
            title: "New Playlist",
            message: "Enter playlist name",
            preferredStyle: .alert
        )
    
        // alert 창 playlist 추가
        alert.addTextField { textField in
            textField.placeholder = "Playlist..."
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: { _ in
            guard let field = alert.textFields?.first,
                  let text = field.text,
                  !text.trimmingCharacters(in: .whitespaces).isEmpty else {
                return
            }
            
            APICaller.shared.createPlaylist(with: text) { success in
                if success {
                    return
                }
                else {
                    print("Failed to create playlist")
                }
            }
        }))
        
        present(alert, animated: true)
    }
    
    
}

