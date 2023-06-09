//
//  RunningInfo.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/08.
//

import Foundation

class RunningInfo: ObservableObject, Identifiable, Codable, Hashable {

    static func == (lhs: RunningInfo, rhs: RunningInfo) -> Bool {
        lhs.id == rhs.id
    }

    var id: Int
    var uid: String
    var date: String
    var runningName: String
    var distance: Double
    var pace: String
    var time: String
    var helpCount: Int
    var picturePath: String
    var cal: Int

    init(id: Int, uid: String, date: String, runningName: String, distance: Double, pace: String, time: String, helpCount: Int, picturePath: String, cal: Int) {
        self.id = id
        self.uid = uid
        self.date = date
        self.runningName = runningName
        self.distance = distance
        self.pace = pace
        self.time = time
        self.helpCount = helpCount
        self.picturePath = picturePath
        self.cal = cal
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(uid)
        hasher.combine(date)
        hasher.combine(runningName)
        hasher.combine(distance)
        hasher.combine(pace)
        hasher.combine(time)
        hasher.combine(helpCount)
        hasher.combine(picturePath)
        hasher.combine(cal)
    }
}

