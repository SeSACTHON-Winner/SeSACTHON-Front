//
//  DangerInfoGroup.swift
//  SeSACTHON_App
//
//  Created by 이재혁 on 2023/06/12.
//

import SwiftUI

class DangerInfoGroup: ObservableObject, Identifiable, Codable {
    var id = UUID()
    var latitude_mod: Double
    var longitude_mod: Double
    var list: [DangerInfoMO] = []
    
    init(latitude_mod: Double, longitude_mod: Double) {
        self.latitude_mod = latitude_mod
        self.longitude_mod = longitude_mod
    }
}
