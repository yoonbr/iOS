//
//  SettingsModels.swift
//  SpotifyClone
//
//  Created by boreum yoon on 2021/06/15.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
    
}
