//
//  SeSACTHON_AppApp.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/05/31.
//

import SwiftUI
import Alamofire

let SIZE = 50.0
let NAME = "RunForYou"

@main
struct SeSACTHON_AppApp: App {
    
    init() {
        // Font 파일 추가 Sample
        Font.registerFonts(fontName: "SF-Pro-Text-BlackItalic")
        WatchSessionManager.sharedManager.startSession()
    }
    
    var body: some Scene {
        WindowGroup {
            if UserDefaults.standard.bool(forKey: "login") {
                HomeView()
                    .onAppear {
                        sleep(1)
                    }
            } else {
                LoginView()
                    .onAppear {
                        sleep(1)
                    }
            }
            
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    func applicationDidEnterBackground(_ application: UIApplication) {
        // 백그라운드로 이동할 때 타이머를 일시 중지
        NotificationCenter.default.post(name: Notification.Name("PauseTimer"), object: nil)
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // 포그라운드로 돌아올 때 타이머를 재개
        NotificationCenter.default.post(name: Notification.Name("ResumeTimer"), object: nil)
    }
}

