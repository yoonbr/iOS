//
//  APICaller.swift
//  SpotifyClone
//
//  Created by boreum yoon on 2021/05/31.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        
    }
}
