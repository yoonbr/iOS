//
//  AuthManager.swift
//  SpotifyClone
//
//  Created by boreum yoon on 2021/05/31.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    // add token 
    struct Constants {
        static let clientID = "8d17827c076743938bb129ea0a1849eb"
        static let clientSecret = "94a6ed62b5424b14ab91901f4d3c9b70"
    }
    
    private init() {}
    
    public var signInURL: URL? {
        let scopes = "user-read-private"
        let redirectURI = "https"
        let base = "https://accounts.spotify.com/authorize"
        let string = "\(base)?response_type=code&client_id=\(Constants.clientID)&scope=\(scopes)&redirect_uri="
    }
    
    var isSignedIn: Bool {
        return false
    }
    
    private var accessToken: String? {
        return nil
    }
    
    private var refreshToken: String? {
        return nil
    }
    
    private var tokenExpirationDate: Date? {
        return nil
    }
    
    private var shouldRefreshToken: Bool {
        return false 
    }
}
