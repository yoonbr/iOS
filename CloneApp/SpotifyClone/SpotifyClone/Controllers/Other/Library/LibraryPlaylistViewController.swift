//
//  LibraryPlaylistViewController.swift
//  SpotifyClone
//
//  Created by boreum yoon on 2021/09/04.
//

import UIKit

class LibraryPlaylistViewController: UIViewController {
    
    var playlists = [Playlist]()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
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
        }
        else {
            // Show table
        }
    }
}
