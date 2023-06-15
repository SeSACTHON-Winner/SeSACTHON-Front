//
//  MainRunningView.swift
//  SeSACTHON_App
//
//  Created by Lee Jinhee on 2023/06/05.
//

import SwiftUI
import Alamofire

struct MainRunningView: View {
    @Binding var swpSelection: Int
    @State var currentDate = Date.now
    @State var showStopConfirmation = false
    @Environment(\.scenePhase) private var scenePhase
    //     @Binding var time: TimeInterval
    //     @State private var timer: Timer?
    @Binding var courseImage: UIImage
    
    @AppStorage("backgroundTime") var backgroundTime: TimeInterval = 0
    @State private var isAnimate = false
    @ObservedObject var rsManager = RunStateManager.shared
    @State private var isPause = false
    @EnvironmentObject var vm: WorkoutViewModel
    var wsManager = WatchSessionManager.sharedManager
    let workout: Workout
    // MARK: - Camera
    @State private var showingImagePicker = false
    @State var pickedImage: Image?
    enum Status: String, CaseIterable {
        case gradient = "경사도"
        case narrow = "좁은 길"
        case road = "높은 단차"
        case natural = "공사중"
    }
    @State var selection: MainRunningView.Status = .gradient
    @State var sendImage: UIImage?
    @ObservedObject var locationManager = LocationDataManager()
    
    @State var isSendNotConfirmed = true
    @ObservedObject var runStateManager = RunStateManager.shared
    
    
    //DateComponentsFormatter().string(from: workout.duration) ?? ""
    var body: some View {
        ZStack {
            if let myImage = pickedImage {
                Color.black.opacity(0.4).ignoresSafeArea()
            }
            VStack {
                VStack {
                    Color.black.frame(height: (pickedImage != nil) ?  64 : 40)
                    HStack {
                        Text("\(formattedTime(rsManager.time))")
                            .foregroundColor(.white)
                            .font(.system(size: 80, weight: .black)).italic()
                    } .padding(.bottom, 4)
                    
                    HStack (alignment: .center){
                        Spacer()
                        VStack {
                            if pickedImage == nil && isPause == false {
                                WorkoutBar(workout: vm.newWorkout, new: true, helpCount: $runStateManager.helpCount)
                            }
                        }
                        Spacer()
                    }
                    Spacer().frame(height: 32)
                }
                .foregroundColor(.white)
                .frame(height: (pickedImage != nil) ?  128 : 242)
                .frame(maxWidth: .infinity)
                .background(Color.black)
                .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
                .shadow(color: .black.opacity(0.25),radius: 4, x: 0, y: 4)
                .onAppear {
                    print(workout.pace)
                }.onDisappear {
                    print(workout.pace)
                }
                
                if let selectedImage = pickedImage {
                    if isSendNotConfirmed {
                        Spacer()
                        Color.white
                            .frame(width: 204, height: 204)
                            .cornerRadius(10)
                            .overlay {
                                selectedImage
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 200, height: 200)
                                    .cornerRadius(10)
                            }
                            .padding(.vertical)
                        Spacer()
                        ForEach(Status.allCases, id:  \.rawValue) { item in
                            HStack {
                                Image("icon_\(returnEngRawvalue(type: item))_main")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30)
                                Text(item.rawValue)
                                    .font(.system(size: 16, weight: selection == item ? .bold : .regular))
                                    .frame(height: 44)
                                    .foregroundColor(Color.init(hex: "808080"))
                                    .onTapGesture {
                                        selection = item
                                    }
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            .background(selection == item ? .white : .white.opacity(0.5))
                            .cornerRadius(16)
                            .shadow(radius: 3, x: 1, y: 3)
                        }
                        .frame(width: 176)
                        .foregroundColor(.white)
                        .padding(.horizontal, 96)
                        Spacer()
                        HStack(spacing: 32) {
                            Button {
                                showingImagePicker = true
                            } label: {
                                Image("CameraButton")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120)
                            }
                            
                            Button {
                                runStateManager.helpCount += 1
                                print("helpCount : \(runStateManager.helpCount)")
                                // 사진 전송
                                var url = URL(string: "http://35.72.228.224/sesacthon/imageSave.php")!
                                
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "yyMMddHHmmss"
                                
                                let currentDate = Date()
                                let formattedDate = dateFormatter.string(from: currentDate)
                                let photoName = "\(formattedDate)"
                                var params = ["uid" : UserDefaults.standard.string(forKey: "uid"), "picture_path" : "\(photoName)"] as Dictionary
                                AF.upload(multipartFormData: { multipartFormData in
                                    if let imageData = sendImage!.jpegData(compressionQuality: 0.5) {
                                        print("\n\n\nimageData.description: \(imageData.description)\n\n\n")
                                        multipartFormData.append(imageData, withName: "photo", fileName: "\(photoName).jpg", mimeType: "image/jpeg")
                                    }
                                }, to: url).response { response in
                                    switch response.result {
                                    case .success(let value):
                                        if let data = value {
                                            // Process the response data as needed
                                            let responseString = String(data: data, encoding: .utf8)
                                            print("Response: \(responseString ?? "")")
                                        }
                                        print("Photo uploaded successfully")
                                        isSendNotConfirmed = false
                                        isPause = false
                                    case .failure(let error):
                                        print("Photo upload failed with error: \(error)")
                                    }
                                }
                                
                                /*
                                 - uid : Apple Login 사용자 identifier 변수 (String)
                                 - latitude : 위도 (Double)
                                 - longitude : 경도 (Double)
                                 - picturePath : 사진 경로, image/전송한파일명.jpg 입니다. (String)
                                 - 이미지 전송 api 사용한 후에 사용할 것
                                 - type : 위험요소 분류, "slope", "construction", "narrow", "step" (String)
                                 */
                                
                                let coordinate = locationManager.returnLocation()
                                url = URL(string: "http://35.72.228.224/sesacthon/dangerInfo.php")!
                                let uid = UserDefaults.standard.string(forKey: "uid")!
                                let dangerparams = ["uid" : uid, "latitude" : coordinate.latitude, "longitude" : coordinate.longitude, "type" : returnEngRaw(), "picturePath" : "images/\(photoName).jpg"] as Dictionary
                                
                                AF.request(url, method: .post, parameters: dangerparams).responseString {
                                    print($0)
                                }
                                
                                url = URL(string: "http://35.72.228.224/sesacthon/helpCount.php")!
                                let totalCountParams = ["uid" : uid] as Dictionary
                                AF.request(url, method: .put, parameters: totalCountParams).responseString {
                                    print($0)
                                }
                            } label: {
                                Image("SendButton")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120)
                            }
                        }
                        .padding(.top)
                        
                        Spacer().frame(height: 80)
                    } else {
                        Spacer()
                        RunningReportSubmitView(selection: $selection, pickedImage: $pickedImage, isSendNotConfirmed: $isSendNotConfirmed, helpCount: $runStateManager.helpCount)
                    }
                } else {
                    
                    Spacer()
                    VStack(spacing: 16) {
                        HStack {
                            if vm.recording {
                                Button {
                                    //MARK: 카메라 찍고 오면 시간은 가는데 버튼 상태는 멈춰있는 상황 해결
                                    rsManager.stopButtonClicked()
                                    rsManager.runState = "stop"
                                    isPause = true
                                    self.showingImagePicker = true
                                }  label: {
                                    Image("FinalCamera").resizable()
                                        .frame(width: 52, height: 52)
                                }
                                .shadow(color: .black.opacity(0.25), radius: 2)
                            }
                            Spacer()
                        }.offset(x: 56, y: 8)
                        HStack(spacing: 50) {
                            if rsManager.runState == "run" {
                                //MARK: StopButton
                                Button {
                                    isPause = true
                                    rsManager.stopButtonClicked()
                                } label: {
                                    Text("STOP")
                                        .font(.system(size: 28, weight: .black))
                                        .italic()
                                        .foregroundColor(.white)
                                        .frame(width: 120, height: 120)
                                        .background(Color("#222222"))
                                        .cornerRadius(60)
                                }.padding(.bottom, 94)
                            }
                            else if rsManager.runState == "stop" {
                                if vm.recording {
                                    //MARK: EndButton
                                    Button {
                                        Task{
                                            print("task")
                                            await rsManager.endButtonClicked(workout: workout, swpSelection: $swpSelection)
                                        }
                                    } label: {
                                        Text("END")
                                            .font(.system(size: 24, weight: .black))
                                            .italic()
                                            .foregroundColor(.white)
                                            .frame(width: 120, height: 120)
                                            .background(Color("#222222"))
                                            .cornerRadius(60)
                                        
                                    }.padding(.bottom, 94)
                                    //MARK: Restart Button
                                    Button {
                                        isPause = false
                                        rsManager.restartButtonClicked(workout: workout)
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
                                                .foregroundColor(Color("#222222"))
                                        }
                                        .frame(width: 120, height: 120)
                                        .overlay(
                                            Text("RESTART")
                                                .font(.system(size: 22, weight: .black))
                                                .italic()
                                                .foregroundColor(Color("MainColor"))
                                        )
                                        .onAppear {
                                            withAnimation(Animation.spring(response: 0.35, dampingFraction: 0.75, blendDuration: 1.0).repeatForever()) {
                                                self.isAnimate.toggle()
                                            }
                                        }
                                    } .padding(.bottom, 94)
                                }
                            }
                        }
                        .onAppear {
                            rsManager.startTimer(workout: workout)
                            // 백그라운드 상태 진입 알림 구독
                            NotificationCenter.default.addObserver(forName: UIApplication.willResignActiveNotification, object: nil, queue: nil) { _ in
                                rsManager.pauseTimer()
                            }
                            // 포그라운드 상태 진입 알림 구독
                            NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: nil) { _ in
                                rsManager.resumeTimer(workout: workout)
                            }
                        }
                        .onDisappear {
                            rsManager.stopTimer()
                            
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
                                rsManager.time += elapsedTime
                            }
                        }
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            .fullScreenCover(isPresented: $showingImagePicker) {
                SUImagePicker(sourceType: .camera) { (image) in
                    sendImage = image
                    self.pickedImage = Image(uiImage: image)
                    print(image)
                }
                .ignoresSafeArea()
            }
        }
        
    }
    
    private func formattedTime(_ time: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        //timeString = formatter.string(from: time) ?? ""
        return formatter.string(from: time) ?? ""
    }
}


extension MainRunningView {
    func returnEngRaw() -> String {
        switch selection {
        case .gradient:
            return "slope"
        case .narrow:
            return "narrow"
        case .natural:
            return "construction"
        case .road:
            return "step"
        }
    }
    
    func returnEngRawvalue(type: Status) -> String {
        switch type {
        case .gradient:
            return "slope"
        case .narrow:
            return "narrow"
        case .natural:
            return "construction"
        case .road:
            return "step"
        }
    }
}
