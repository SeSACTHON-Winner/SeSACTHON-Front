//
//  DangerInfoMO.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/08.
//

import Foundation

class DangerInfoMO: ObservableObject, Identifiable {
    
    @Published var id: String
    @Published var latitude: Double
    @Published var longtitude: Double
    @Published var picturePath: String
    @Published var type: DangerType
    
    init(id: String, latitude: Double, longtitude: Double, picturePath: String, type: DangerType) {
        self.id = id
        self.latitude = latitude
        self.longtitude = longtitude
        self.picturePath = picturePath
        self.type = type
    }
    
    
    enum DangerType: String {
        
        case step = "step"
        case slope = "slope"
        case construction = "construction"
        case narrow = "narrow"
    }
}
