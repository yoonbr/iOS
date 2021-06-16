//
//  FeaturedPlaylistsResponse.swift
//  SpotifyClone
//
//  Created by boreum yoon on 2021/06/16.
//

import Foundation

struct FeaturedPlaylistsResponse: Codable {
    let playlists: PlaylistResponse
}

struct PlaylistResponse: Codable {
    let items: [Playlist]
}

struct Playlist: Codable {
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let owner: User
    
}

struct User: Codable {
    let display_name: String
    let external_urls: [String: String]
    let id: String
}
