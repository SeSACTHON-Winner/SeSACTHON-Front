//
//  MainRunningView.swift
//  SeSACTHON_App
//
//  Created by Lee Jinhee on 2023/06/05.
//

import SwiftUI
//TODO: RootView랑 MainRunningView 합칠 예정,,
struct MainRunningView: View {
    @Binding var swpSelection: Int
    @State var currentDate = Date.now
    @State var runState = "run"
    
    @State var showStopConfirmation = false

    @Environment(\.scenePhase) private var scenePhase
    @State private var time: TimeInterval = 0
    @State private var timer: Timer?
    @AppStorage("backgroundTime") var backgroundTime: TimeInterval = 0
    @State private var isAnimate = false

    @EnvironmentObject var vm: WorkoutViewModel
    
    let workout: Workout
    
    //DateComponentsFormatter().string(from: workout.duration) ?? ""
    var body: some View {
        VStack {
            VStack {
                Spacer().frame(height: 60)
                HStack {
                    // 기존 timer
                    // Text("\(formattedTime(time))")
                    //workout timer Version
                    Text(DateComponentsFormatter().string(from: workout.duration) ?? "")
                        .foregroundColor(.white)
                        .font(.system(size: 48, weight: .black)).italic()
                    Spacer()
                }.padding(.leading, 28)
            }
            .foregroundColor(.white)
            .frame(height: 120)
            .frame(maxWidth: .infinity)
            .background(Color.black)
            .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
            .shadow(color: .black.opacity(0.25),radius: 4, x: 0, y: 4)
            
            Spacer()
            NavigationLink {
                CustomCameraView()
            }  label: {
                Image(systemName: "bell.fill")
                    .font(.system(size: 28, weight: .black))
                    .italic()
                    .foregroundColor(.black)
                    .frame(width: 52, height: 52)
                    .background(Color("MainColor"))
                    .cornerRadius(26)
                
            }
            .shadow(color: .black.opacity(0.25), radius: 2)
            .padding(.bottom, 8)
            
            
            HStack(spacing: 50) {
                if runState == "run" {
                    Button {
                        stopTimer()
                        runState = "stop"
                    } label: {
                        Text("STOP")
                            .font(.system(size: 28, weight: .black))
                            .italic()
                            .foregroundColor(.white)
                            .frame(width: 120, height: 120)
                            .background(.black)
                            .cornerRadius(60)
                    }.padding(.bottom, 60)
                }
                else if runState == "stop" {
                    if vm.recording {
                        Button {
                            stopTimer()
                            showStopConfirmation = true
                            
                        } label: {
                            Text("END")
                                .font(.system(size: 24, weight: .black))
                                .italic()
                                .foregroundColor(.white)
                                .frame(width: 120, height: 120)
                                .background(.black)
                                .cornerRadius(60)
                        }
                        .padding(.bottom, 60)
                        .confirmationDialog("Stop Workout?", isPresented: $showStopConfirmation, titleVisibility: .visible) {
                            Button("Cancel", role: .cancel) {}
                            Button("Stop & Discard", role: .destructive) {
                                vm.discardWorkout()
                                
                            }
                            Button("Finish & Save") {
                                Task {
                                    await vm.endWorkout()
                                    
                                }
                                swpSelection = 3
                            }
                        }
                        
                        Button {
                            runState = "run"
                            startTimer()
                        } label: {
                            ZStack {
                                Circle()
                                    .foregroundColor(Color("MainColor"))
                                    .scaleEffect(isAnimate ? 1.35 : 1.0)
                                    .opacity(isAnimate ? 0.5 : 0)
                                
                                Circle()
                                    .foregroundColor(Color("MainColor"))
                                    .scaleEffect(isAnimate ? 1.2 : 1.0)
                                    .opacity(isAnimate ? 0.8 : 0)
                                Circle()
                                    .foregroundColor(.black)
                            }
                            .frame(width: 120, height: 120)
                            .overlay(
                                Text("RESTART")
                                    .font(.system(size: 24, weight: .black))
                                    .italic()
                                    .foregroundColor(Color("MainColor"))
                                    .cornerRadius(60)
                            )
                            .onAppear {
                                withAnimation(Animation.spring(response: 0.35, dampingFraction: 0.75, blendDuration: 1.0).repeatForever()) {
                                    self.isAnimate.toggle()
                                    
                                }
                            }
                        } .padding(.bottom, 60)
                        
                    }
                    
                  
                    
                    
//                    Button {
//                        runState = "run"
//                        startTimer()
//                    } label: {
//                        ZStack {
//                            Circle()
//                                .foregroundColor(Color("MainColor"))
//                                .scaleEffect(isAnimating ? 1.35 : 1.0)
//                                .opacity(isAnimating ? 0.5 : 0)
//
//                            Circle()
//                                .foregroundColor(Color("MainColor"))
//                                .scaleEffect(isAnimating ? 1.2 : 1.0)
//                                .opacity(isAnimating ? 0.8 : 0)
//                            Circle()
//                                .foregroundColor(.black)
//                        }
//                        .frame(width: 120, height: 120)
//                        .overlay(
//                            Text("RESTART")
//                                .font(.system(size: 24, weight: .black))
//                                .italic()
//                                .foregroundColor(Color("MainColor"))
//                                .frame(width: 120, height: 120)
//                                .background(.black)
//                                .cornerRadius(60)
//
//                        )
//                        .onAppear {
//                            withAnimation(Animation.spring(response: 0.35, dampingFraction: 0.75, blendDuration: 1.0).repeatForever()) {
//                                self.isAnimating.toggle()
//
//                            }
//                        }
//                    }
//                    .padding(.bottom, 60)
                    
                }
            }
            .onAppear {
                startTimer()
                // 백그라운드 상태 진입 알림 구독
                NotificationCenter.default.addObserver(forName: UIApplication.willResignActiveNotification, object: nil, queue: nil) { _ in
                    pauseTimer()
                }
                // 포그라운드 상태 진입 알림 구독
                NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: nil) { _ in
                    resumeTimer()
                }
            }
            .onDisappear {
                stopTimer()
                
                // 알림 구독 해제
                NotificationCenter.default.removeObserver(self)
            }
            
            .onChange(of: scenePhase) { phase in
                if phase == .background {
                    // Store the current time in the background
                    backgroundTime = Date().timeIntervalSinceReferenceDate
                } else if phase == .active {
                    // Calculate the elapsed time when returning to the foreground
                    let foregroundTime = Date().timeIntervalSinceReferenceDate
                    let elapsedTime = foregroundTime - backgroundTime
                    time += elapsedTime
                }
            }
        }.edgesIgnoringSafeArea(.all)
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            DispatchQueue.main.async {
                self.time += 1
            }
        }
        
        DispatchQueue.global(qos: .background).async {
            RunLoop.current.add(self.timer!, forMode: .common)
            RunLoop.current.run()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func formattedTime(_ time: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        //timeString = formatter.string(from: time) ?? ""
        return formatter.string(from: time) ?? ""
    }
    
    // 백그라운드 상태 진입 시 타이머 일시 중지
    private func pauseTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    // 포그라운드 상태 진입 시 타이머 재개
    private func resumeTimer() {
        startTimer()
    }
}

//struct MainRunningView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainRunningView(swpSelection: .constant(2))
//    }
//}
