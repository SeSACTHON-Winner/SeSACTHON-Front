//
//  MintSystemImageLabelStyle.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/04.
//

import Foundation
import SwiftUI

struct MintSystemImageLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.icon
                .foregroundColor(.mint) // Set the color of the system image to blue
            configuration.title
        }
    }
}
