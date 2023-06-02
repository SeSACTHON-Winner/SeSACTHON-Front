//
//  SeSACTHON_AppApp.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/05/31.
//

import SwiftUI

@main
struct SeSACTHON_AppApp: App {
    
    init() {
        // Font 파일 추가 Sample
        Font.registerFonts(fontName: "SF-Pro-Text-BlackItalic")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
