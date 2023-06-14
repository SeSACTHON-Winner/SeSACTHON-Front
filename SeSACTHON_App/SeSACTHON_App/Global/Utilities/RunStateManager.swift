//
//  RunStateManager.swift
//  SeSACTHON_App
//
//  Created by musung on 2023/06/14.
//

import Foundation
import SwiftUI
class RunStateManager : ObservableObject{
    @Published  var runState = "run"
    @Published var time: TimeInterval = 0
    private var timer: Timer?
    var wsManager = WatchSessionManager.sharedManager
    var vm : WorkoutViewModel?
    var courseImage: UIImage = UIImage()
    static let shared = RunStateManager()
    init(){
    }
    func initialize(vm: WorkoutViewModel) {
        self.vm = vm
    }
    func stopButtonClicked(){
        stopTimer()
        runState = "stop"
        Haptics.tap()
        wsManager.sendPause()
    }
    func endButtonClicked(workout : Workout,swpSelection : Binding<Int>)async{
        stopTimer()
         wsManager.sendStop()
        await vm!.zoomTo(workout)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if let img = self.vm!.saveMapViewAsImage() {
                self.courseImage = img
            }
        }
         Task {
             await vm!.endWorkout()
         }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
             swpSelection.wrappedValue = 3
         }
        ////
        Haptics.tap()
         stopTimer()
    }
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            DispatchQueue.main.async {
                self.wsManager.sendWatchRunDao()
                self.time += 1
            }
        }
        
        DispatchQueue.global(qos: .background).async {
            RunLoop.current.add(self.timer!, forMode: .common)
            RunLoop.current.run()
        }
    }
    func restartButtonClicked(){
        Haptics.tap()
        runState = "run"
        startTimer()
        wsManager.sendStart()
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    // 백그라운드 상태 진입 시 타이머 일시 중지
     func pauseTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    // 포그라운드 상태 진입 시 타이머 재개
     func resumeTimer() {
        startTimer()
    }
}
