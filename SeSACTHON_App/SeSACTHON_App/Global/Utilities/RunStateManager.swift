//
//  RunStateManager.swift
//  SeSACTHON_App
//
//  Created by musung on 2023/06/14.
//

import Foundation
import SwiftUI
class RunStateManager : ObservableObject{
    @Published var runState = "run"
    @Published var time: TimeInterval = 0
    private var timer: Timer?
    var wsManager = WatchSessionManager.sharedManager
    var vm : WorkoutViewModel?
    var courseImage: UIImage = UIImage()
    static let shared = RunStateManager()
    @Published var pause: Bool = false
    
    init(){
        
    }
    func initialize(vm: WorkoutViewModel) {
        self.runState = "run"
        self.vm = vm
        self.time = 0
        self.pause = false
    }
    func stopButtonClicked(){
        stopTimer()
        runState = "stop"
        pause = true
        Haptics.tap()
        wsManager.sendPause()
    }
    func endButtonClicked(swpSelection : Binding<Int>)async{
        stopTimer()
        //time = 0
        //TODO: 라딘 추가사항 확인
        wsManager.sendStop()
        await vm!.zoomTo(vm!.newWorkout)
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
        wsManager.watchRunDAO = WatchRunDAO()
    }
    func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] timer in
            print("timer : \(Double(time))")
            self.wsManager.watchRunDAO.fetchChange(workout: vm!.newWorkout,duration:Double(time+1))
            print("watchRundDao.distance : \(self.wsManager.watchRunDAO.distance)")
            DispatchQueue.main.async {
                self.wsManager.sendWatchRunDao()
                print("wsManager.watchRunDAO.duration = \(self.wsManager.watchRunDAO.duration)")
                self.time += 1
            }
        }
//
//        DispatchQueue.global(qos: .background).async {
//            RunLoop.current.add(self.timer!, forMode: .common)
//            RunLoop.current.run()
//        }
    }
    func startButtonClicked(){
        Haptics.tap()
        //TODO: 라딘 추가 사항 - 확인
        runState = "run"
        pause = false
        //wsManager.sendStart()
    }
    func restartButtonClicked(){
        Haptics.tap()
        runState = "run"
        pause = false
        startTimer()
        wsManager.sendStart()
    }
    //라딘 추가
    func sendButtonClicked() {
       // plusHelpCount()
        pause = false
        wsManager.sendPlusHelpCount()
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
