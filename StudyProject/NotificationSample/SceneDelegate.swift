//
//  SceneDelegate.swift
//  NotificationSample
//
//  Created by boreum yoon on 2021/02/25.
//

import UIKit

import UserNotifications

class SceneDelegate: UIResponder, UIWindowSceneDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    
    // 앱이 실행되고 처음 화면이 만들어졌을 때 호출되는 메소드
    // 윈도우가 생성되지 않으면 종료
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // 알림 설정을 하기 위한 권한 요청
        // .alert(대화상자), .badge(알림 뱃지), .sound(사운드)
        let notiCenter = UNUserNotificationCenter.current()
        notiCenter.requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {(didAllow, e) -> Void in})
        
        // Notification의 이벤트 처리를 위임
        notiCenter.delegate = self
        
        // guard : 중간에 끝내버릴 때 실행되는 메소드
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    // 화면 연결이 끊어지는 경우 호출
    func sceneDidDisconnect(_ scene: UIScene) {
        
    }
    
    // 화면이 활성화 될 때 호출되는 메소드
    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }
    
    // 백그라운드로 진입할 때 호출되는 메소드
    func sceneWillResignActive(_ scene: UIScene) {
        // 로컬 알림 생성
        UNUserNotificationCenter.current().getNotificationSettings(completionHandler: {(settings) -> Void in
            
            // 권한의 존재 여부를 확인
            if settings.authorizationStatus == UNAuthorizationStatus.authorized {
                
                // 알림 컨텐츠 생성
                let nContent = UNMutableNotificationContent()
                nContent.badge = 1
                // 뱃지가 사라짐
                UIApplication.shared.applicationIconBadgeNumber = 0
                nContent.title = "로컬 알림"
                nContent.subtitle = "알림 메시지 내용"
                nContent.body = "Hello!"
                
                nContent.sound = UNNotificationSound.default
                
                // userinfo는 Dictionary 이고
                // 호출되는 메소드에게 넘기는 부가정보
                nContent.userInfo = ["name":"관리자"]
                
                // 알림을 실행하기 위한 조건 - trigger
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
                
                // 알림 내용과 조건을 묶기
                let request = UNNotificationRequest(identifier: "wakeUp", content: nContent, trigger: trigger)
                
                // 등록
                UNUserNotificationCenter.current().add(request)
                
            } else {
                NSLog("사용자가 알림을 허용하지 않음")
            }
        })
       
    }

    // 포그라운드로 진입할 때 호출되는 메소드
    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    // 백그라운드로 진입한 후 호출되는 메소드
    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
    
    // wakeUp 이라는 알림이 보여지기 위해서 만들어지면 호출되는 메소드
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // wakeUp 이라는 알림이 발생된다면
        if notification.request.identifier == "wakeUp" {
            let userInfo = notification.request.content.userInfo
            NSLog(userInfo["name"] as! String)
        }
        // 알림을 출력
        completionHandler([.banner, .badge, .sound])
    }
    
    // 로컬 알림을 누르면 호출되는 메소드
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "wakeUp"{
            NSLog("알림을 클릭")
        }
        completionHandler()
    }
}
