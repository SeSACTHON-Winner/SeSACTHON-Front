//
//  WatchRunDAO.swift
//  SeSACTHON_App
//
//  Created by musung on 2023/06/13.
//

import Foundation

struct WatchRunDAO : Codable,Hashable{
    var isStart:Bool
    var isPause:Bool
    var isStop:Bool
    var duration: Double
    var distance: Double
    var helpNum: Int
    
    init() {
        self.isStart = false
        self.isPause = false
        self.isStop = false
        self.duration = 0.0
        self.distance = 0.0
        self.helpNum = 0
    }
    #if os(iOS)
    mutating func fetchChange(workout: Workout,duration: Double){
        self.duration = duration
        self.distance = workout.distance
    }
    #endif
    
    mutating func start() -> WatchRunDAO{
        self.isStart = true;
        self.isPause = false;
        self.isStop = false;
        return self;
    }
    mutating func pause() -> WatchRunDAO{
        self.isStart = true;
        self.isPause = true;
        self.isStop = false;
        return self;
    }
    mutating func stop() -> WatchRunDAO{
        self.isStart = false;
        self.isPause = false;
        self.isStop = true;
        return self;
    }
    //라딘 수정
    mutating func plus() -> WatchRunDAO{
        self.helpNum += 1
        return self;
    }
}
