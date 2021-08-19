//
//  PlaybackPresenter.swift
//  SpotifyClone
//
//  Created by boreum yoon on 2021/08/14.
//

import Foundation
import UIKit

protocol PlayerDataSource: AnyObject {
    var songName: String? { get }
    var subtitle: String? { get }
    var imageURL: URL? { get }
}

final class PlaybackPresenter {
    
    static let shared = PlaybackPresenter()
    
    func startPlayback(
        from viewController: UIViewController,
        track: AudioTrack
    ) {
        let vc = PlayerViewController()
        vc.title = track.name
        viewController.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
     func startPlayback(
        from viewController: UIViewController,
        tracks: [AudioTrack]
    ) {
        // 모두 재생 버튼 누를때 화면 띄우기 
        let vc = PlayerViewController()
        viewController.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }

}
