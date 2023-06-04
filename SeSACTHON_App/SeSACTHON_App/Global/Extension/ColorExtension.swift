//
//  ColorExtension.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/05/31.
//

import SwiftUI

extension Color {
    
    // Color Pallete Sample
   /*
    static let black = Color(hex: "000000")
    static let white = Color(hex: "FFFFFF")
    static let redStrong = Color(hex: "E10000")
    static let redLight = Color(hex: "F68383")
    static let orangeStrong = Color(hex: "FF5C00")
    static let orangeLight = Color(hex: "FFAF82")
    static let yellowStrong = Color(hex: "FFCC00")
    static let yellowLight = Color(hex: "FFE477")
    */
    
    static let sesacMint = Color.init(hex: "03FFF0")
    
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
      }
}
