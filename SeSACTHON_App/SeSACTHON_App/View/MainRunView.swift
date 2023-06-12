//
//  MainRunView.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/01.
//

import SwiftUI
import MapKit
import Alamofire

struct MainRunView: View {
    @State private var swpSelection = 0
    //var healthDataManager = HealthDataManager()
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 36.0190178, longitude: 129.3434893), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    @StateObject var vm = WorkoutViewModel()
    
    var body: some View {
        ZStack {
            switch swpSelection {
            case 0, 1, 2:
                VStack(spacing: 0) {
                    //                    CustomMapView(userTrackingMode: self.$userTrackingMode, region: self.$region)
                    //                        .ignoresSafeArea()
                    RootView(swpSelection: $swpSelection, region: $region)
                }
            default:
                EmptyView()
            }
            
            switch swpSelection {
            case 0:
                MainRunHomeView(swpSelection: $swpSelection)
            case 1:
                MainRunStart(swpSelection: $swpSelection)
            case 2:
                MainRunningView(swpSelection: $swpSelection, workout: vm.newWorkout)
                    .onAppear {
                        Task {
                            await vm.startWorkout(type: .running)
                        }
                    }
            case 3:
                RunEndView(swpSelection: $swpSelection, workout: vm.selectedWorkout ?? .example)
                
            default:
                EmptyView()
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            //healthDataManager.requestHealthAuthorization()
        }
        .environmentObject(vm)
    }
}

struct MainRunStart: View {
    @Binding var swpSelection: Int
    @State private var startCount = "3."
    @State private var startText = "Are"
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            VStack {
                Spacer().frame(height: 80)
                Text("\(startCount)").foregroundColor(.white)
                    .font(.system(size: 96, weight: .black)).italic()
            }
            .foregroundColor(.white)
            .frame(height: 208)
            .frame(maxWidth: .infinity)
            .background(Color.black)
            .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
            .shadow(color: .black.opacity(0.25),radius: 4, x: 0, y: 4)
            
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    startCount = "2."
                    startText = "You"
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                        startCount = "1."
                        startText = "Ready?"
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                            startCount = "Go !"
                            startText = "Stop"
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                                swpSelection = 2
                            }
                        }
                    }
                }
                
            }
            Spacer()
            Button {
                swpSelection = 2
            } label: {
                ZStack {
                    Circle()
                        .foregroundColor(Color("MainColor"))
                        .scaleEffect(isAnimating ? 1.35 : 1.0)
                        .opacity(isAnimating ? 0.5 : 0)
                    
                    Circle()
                        .foregroundColor(Color("MainColor"))
                        .scaleEffect(isAnimating ? 1.2 : 1.0)
                        .opacity(isAnimating ? 0.8 : 0)
                    Circle()
                        .foregroundColor(.black)
                }
                .frame(width: 120, height: 120)
                .overlay(
                    Text("\(startText)")
                        .font(.system(size: 28, weight: .black))
                        .italic()
                        .foregroundColor(.white)
                )
                .onAppear {
                    withAnimation(Animation.spring(response: 0.35, dampingFraction: 0.75, blendDuration: 1.0).repeatCount(8)) {
                        self.isAnimating.toggle()
                        
                    }
                }
            }
            .padding(.bottom, 94)
        }
        .edgesIgnoringSafeArea(.all)
    }
}


struct MainRunHomeView: View {
    @State var searchText = ""
    @State var showRoute = false
    @State var isPlaceSelected = false
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    @State var address = ""
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    let layout = [
        GridItem(.flexible())
    ]
    @Binding var swpSelection: Int
    @ObservedObject var locationManager = LocationDataManager()
    
    @EnvironmentObject var vm: WorkoutViewModel
    
    // MARK: - Camera
    @State private var showingImagePicker = false
    @State var pickedImage: Image?
    enum Status: String, CaseIterable {
        case gradient = "🎢 경사도"
        case narrow = "⛔ 좁은 길"
        case road = "↕️ 높은 턱"
        case natural = "🚧 공사중"
    }
    @State var selection: Status = .gradient
    
    @State var sendImage: UIImage?
    
    
    var body: some View {
        ZStack {
            
            VStack(spacing: 0) {
                Color.black.frame(height: 50)
                TopProfileView(title: "RUN")
                    .padding(.horizontal, 20)
                    .background(.black)
                
                HStack {
                    Image(systemName: "location.fill")
                        .resizable()
                        .foregroundColor(.blue)
                        .frame(width: 20, height: 20)
                    Text(locationManager.address).foregroundColor(.white)
                        .font(.system(size: 17, weight: .regular))
                }
                .foregroundColor(.white)
                .frame(height: 76)
                .frame(maxWidth: .infinity)
                .background(Color.black)
                .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
                .shadow(color: .black.opacity(0.25),radius: 4, x: 0, y: 4)
                
                
                if let selectedImage = pickedImage {
                    
                    selectedImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .cornerRadius(10)
                        .padding(.vertical)
                    ForEach(Status.allCases, id:  \.rawValue) { item in
                        Text(item.rawValue)
                            .font(.system(size: 16, weight: selection == item ? .bold : .regular))
                            .frame(height: 44)
                            .onTapGesture {
                                selection = item
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            .background(selection == item ? .black : .black.opacity(0.5))
                            .cornerRadius(16)
                            .padding(.bottom)
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 96)
                    HStack {
                        Button {
                            showingImagePicker = true
                        } label: {
                            Image("CameraButton")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120)
                        }
                        Button {
                            
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
                                    self.pickedImage = nil
                                    
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
                            
                            
                            
                            
                            
                        } label: {
                            Image("SendButton")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120)
                        }
                        
                    }
                    
                    Spacer()
                } else {
                    Spacer().frame(height: 80)
                    // MARK: - 말풍선
                    SpeechBubble(text: "오늘은 경사도 높은 길을\n찾아볼까요?")
                    //Color.black.frame(height: 100)
                    Spacer()
                    HStack(alignment: .top, spacing: 28) {
                        
                        Button {
                            self.showingImagePicker = true
                        } label: {
                            Image("RunCamera").resizable()
                                .frame(width: 52, height: 52)
                        }
                        .fullScreenCover(isPresented: $showingImagePicker) {
                            SUImagePicker(sourceType: .camera) { (image) in
                                self.sendImage = image
                                self.pickedImage = Image(uiImage: image)
                                print(image)
                            }
                            .ignoresSafeArea()
                        }
                        
                        Button {
                            swpSelection = 1
                        } label: {
                            Text("Go")
                                .font(.system(size: 32, weight: .black))
                                .italic()
                                .foregroundColor(.white)
                                .frame(width: 120, height: 120)
                                .background(Color("#222222"))
                                .cornerRadius(60)
                        }
                        Button {
                            //self.userTrackingMode = .follow
                            updateTrackingMode()
                        } label: {
                            Image("RunLocation")
                                .resizable()
                                .frame(width: 52, height: 52)
                        }
                    }.padding(.bottom, 60)
                }
                
                
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .edgesIgnoringSafeArea(.top)
    }
    
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
    
    func updateTrackingMode() {
        var mode: MKUserTrackingMode {
            switch vm.trackingMode {
            case .none:
                return .follow
            case .follow:
                return .followWithHeading
            default:
                return .none
            }
        }
        //ViewModel의 updateTrackingMode() 함수를 호출하고 계산된 "mode" 변수를 전달합니다.
        vm.updateTrackingMode(mode)
    }
    
    var trackingModeImage: String {
        switch vm.trackingMode {
        case .none:
            return "location.circle"
        case .follow:
            return "location.circle.fill"
        default:
            return "location.north.line.fill"
        }
    }
    
}
struct MainRunView_Previews: PreviewProvider {
    static var previews: some View {
        MainRunView()
    }
}
