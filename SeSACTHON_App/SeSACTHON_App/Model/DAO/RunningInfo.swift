//
//  RunningInfo.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/08.
//

import Foundation

class RunningInfo: ObservableObject, Identifiable {
    
    @Published var id: Int
    @Published var uid: String
    @Published var date: Date
    @Published var runningName: String
    @Published var distance: Double
    @Published var pace: String
    @Published var time: String
    @Published var helpCount: Int
    @Published var picturePath: String

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
