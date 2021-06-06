//
//  AuthResponse.swift
//  SpotifyClone
//
//  Created by boreum yoon on 2021/06/05.
//

import Foundation

struct AuthResponse: Codable {
    let access_token: String
    let expires_in: Int
    let refresh_token: String
    let scope: String
    let token_type: String 
}
