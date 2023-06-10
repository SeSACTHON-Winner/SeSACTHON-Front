//
//  CustomCameraView.swift
//  SeSACTHON_App
//
//  Created by Lee Jinhee on 2023/06/02.
//

import SwiftUI

struct CustomCameraView: View {
    @ObservedObject var viewModel = CameraViewModel()
    
    var body: some View {
        ZStack {
            if let previewImage = viewModel.recentImage {
                VStack {
                    Image(uiImage: previewImage)
                        .resizable()
                        .frame(width: 260, height: 260)
                        .aspectRatio(contentMode: .fit)
                        
                    SelectStatusView()
                }
            } else {
                viewModel.cameraPreview.ignoresSafeArea()
                    .onAppear {
                        viewModel.configure()
                    }
                
                VStack {
                    HStack {
                        // 셔터사운드 온오프
                        Button(action: {viewModel.switchFlash()}) {
                            Image(systemName: viewModel.isFlashOn ?
                                  "speaker.fill" : "speaker")
                            .foregroundColor(viewModel.isFlashOn ? .yellow : .white)
                        }
                        .padding(.horizontal, 30)
                        
                        // 플래시 온오프
                        Button(action: {viewModel.switchSilent()}) {
                            Image(systemName: viewModel.isSilentModeOn ?
                                  "bolt.fill" : "bolt")
                            .foregroundColor(viewModel.isSilentModeOn ? .yellow : .white)
                        }
                        .padding(.horizontal, 30)
                    }
                    .font(.system(size:25))
                    .padding()
                    
                    Spacer()
                    
                    Button {
                        viewModel.capturePhoto()
                    } label: {
                        Image("Camera")
                        //  .padding()
                    }
                }
                .foregroundColor(.white)
            }
        }.navigationBarBackButtonHidden()
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
//       CustomCameraView()
        SelectStatusView()
    }
}


enum Status: String, CaseIterable {
    case gradient = "🎢 경사도"
    case narrow = "⛔ 좁은 길"
    case road = "↕️ 높은 단차"
    case natural = "🚧 공사중"
}

struct SelectStatusView: View {
    @State var selection: Status = .gradient
    @ObservedObject var locationManager = LocationDataManager()

    var gridItem = [ GridItem(.flexible(), spacing: 8) ]
    var body: some View {
        VStack {
            HStack {
                Text(locationManager.address)
                    .foregroundColor(.white)
                    .font(.system(size: 17, weight: .regular))
            }
            .foregroundColor(.white)
            .frame(height: 96)
            .frame(maxWidth: .infinity)
            .background(Color.black)
            .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
            .shadow(color: .black.opacity(0.25),radius: 4, x: 0, y: 4)
            
            Spacer()
            LazyVGrid(columns: gridItem) {
                ForEach(Status.allCases, id:  \.rawValue) { item in
                    Text(item.rawValue)
                        .font(.system(size: 16, weight: selection == item ? .bold : .regular))
                        .frame(height: 60)
                        .onTapGesture {
                            selection = item
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(selection == item ? .black : .black.opacity(0.5))
                }
                .foregroundColor(.white)
                .cornerRadius(16)
                .padding(.horizontal, 96)
            }
            //.shadow(color: .black.opacity(0.15) ,radius: 4, x: 2, y: 2)
            .padding(.bottom, 96)
            
            HStack(spacing: 32) {
                Button {
                    //TODO: pop? binding으로 이전뷰로 넘기기
                } label: {
                    Image("camerabig")
                        .resizable()
                }
                .frame(width: 120, height: 120)
                
                NavigationLink {
                    ReportSubmitView(selection: $selection)
                } label: {
                    Image("send") .resizable()
                }
                .frame(width: 120, height: 120)
            }
            .padding(.bottom, 93)
            
        }.edgesIgnoringSafeArea(.all)
       
    }
}
