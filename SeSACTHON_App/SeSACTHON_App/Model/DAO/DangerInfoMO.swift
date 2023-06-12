//
//  DangerInfoMO.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/08.
//

import SwiftUI
import Combine

class DangerInfoMO: ObservableObject, Identifiable, Codable {
    
    var id: Int
    var uid: String
    var latitude: Double
    var longitude: Double
    var picturePath: String
    var type: String
    
    init(id: Int, uid: String, latitude: Double, longitude: Double, picturePath: String, type: DangerType) {
        self.id = id
        self.uid = uid
        self.latitude = latitude
        self.longitude = longitude
        self.picturePath = picturePath
        self.type = type.rawValue
    }
}

enum DangerType: String, Codable {
    case step = "step"
    case slope = "slope"
    case construction = "construction"
    case narrow = "narrow"
}
