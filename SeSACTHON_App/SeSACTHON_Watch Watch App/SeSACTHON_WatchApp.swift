//
//  SeSACTHON_WatchApp.swift
//  SeSACTHON_Watch Watch App
//
//  Created by ChoiYujin on 2023/06/04.
//

import SwiftUI

@main
struct SeSACTHON_Watch_Watch_AppApp: App {
    
    init() {
        // Font 파일 추가 Sample
        Font.registerFonts(fontName: "SF-Pro-Text-BlackItalic")
        WatchSessionManager.sharedManager.startSession()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack() {
                StartView()
            }
            .tint(.sesacMint)
        }
    }
}
