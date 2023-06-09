//
//  RunningInfo.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/08.
//

import Foundation

class RunningInfo: ObservableObject, Identifiable, Codable {
    
    var id: Int
    var uid: String
    var date: Date
    var runningName: String
    var distance: Double
    var pace: String
    var time: String
    var helpCount: Int
    var picturePath: String

    init(id: Int, uid: String, date: Date, runningName: String, distance: Double, pace: String, time: String, helpCount: Int, picturePath: String) {
        self.id = id
        self.uid = uid
        self.date = date
        self.runningName = runningName
        self.distance = distance
        self.pace = pace
        self.time = time
        self.helpCount = helpCount
        self.picturePath = picturePath
    }
    
}
