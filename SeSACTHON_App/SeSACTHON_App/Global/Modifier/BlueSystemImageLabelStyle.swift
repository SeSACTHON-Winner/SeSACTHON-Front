//
//  BlueSystemImageLabelStyle.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/02.
//

import Foundation
import SwiftUI

struct BlueSystemImageLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.icon
                .foregroundColor(.blue) // Set the color of the system image to blue
            configuration.title
        }
    }
}
