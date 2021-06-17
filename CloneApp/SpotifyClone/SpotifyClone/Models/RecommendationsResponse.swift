//
//  RecommendationsResponse.swift
//  SpotifyClone
//
//  Created by boreum yoon on 2021/06/17.
//

import Foundation

struct RecommendationsResponse: Codable {
    let tracks: [AudioTrack]
}
