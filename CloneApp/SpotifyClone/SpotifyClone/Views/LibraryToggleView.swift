//
//  LibraryToggleView.swift
//  SpotifyClone
//
//  Created by boreum yoon on 2021/09/04.
//

import UIKit

protocol LibraryToggleViewDelegate: AnyObject {
    func libraryToggleViewDidTapPlaylist(_ toggleView: LibraryToggleView)
    func libraryToggleViewDidTapAlbums(_ toggleView: LibraryToggleView)
}

class LibraryToggleView: UIView {
    
    weak var delegate: LibraryToggleViewDelegate?
    
    // button 추가
    private let playlistButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Playlists", for: .normal)
        return button
    }()
    
    private let albumsButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Albums", for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(playlistButton)
        addSubview(albumsButton)
        
        playlistButton.addTarget(self, action: #selector(didTapPlaylist), for: .touchUpInside)
        albumsButton.addTarget(self, action: #selector(didTapAlbums), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc private func didTapPlaylist() {
        delegate?.libraryToggleViewDidTapPlaylist(self)
    }
    
    @objc private func didTapAlbums() {
        delegate?.libraryToggleViewDidTapAlbums(self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // button size
        playlistButton.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        albumsButton.frame = CGRect(x: playlistButton.right, y: 0, width: 100, height: 50)
    }
}
