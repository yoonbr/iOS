//
//  SearchResult.swift
//  SpotifyClone
//
//  Created by boreum yoon on 2021/07/15.
//

import Foundation

enum SearchResult {
    case artist(model: Artist)
    case album(model: Album)
    case track(model: AudioTrack)
    case playlist(model: Playlist)
    
}
