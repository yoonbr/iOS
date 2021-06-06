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
        static let tokenAPIURL = "https://accounts.spotify.com/api/token"
    }
    
    private init() {}
    
    public var signInURL: URL? {
        let scopes = "user-read-private"
        let redirectURI = "https://localhost/callback/"
        let base = "https://accounts.spotify.com/authorize"
        let string = "\(base)?response_type=code&client_id=\(Constants.clientID)&scope=\(scopes)&redirect_uri=\(redirectURI)&show_dialog=TRUE" 
        return URL(string: string)
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
    
    public func exchangeCodeForToken(
        code: String,
        completion: @escaping ((Bool) -> Void)
    ) {
        // Get token
        guard let url = URL(string: Constants.tokenAPIURL) else {
            return
        }
        
        // setting request parameter to json
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type",
                         value: "authorization_code"),
            URLQueryItem(name: "code",
                         value: code),
            URLQueryItem(name: "redirect_uri",
                         value: "https://localhost/callback/")
        ]
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded",
                         forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        
        let basicToken = Constants.clientID+":"+Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("Failure to get base64")
            completion(false)
            return
        }
        
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(
                    with: data,
                    options: .allowFragments
                )
                
                print("SUCCESS: \(json)")
                completion(true)
                }
            catch {
                print(error.localizedDescription)
                completion(false)
            }
        }
        // fix of api call
        task.resume()
        
    }
    
    public func refreshAccessToken() {
        
    }
    
    private func cacheToken() {
        
    }
}
