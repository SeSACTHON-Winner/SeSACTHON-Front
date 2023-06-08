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
                ZStack {
                    Image(uiImage: previewImage)
                        .resizable()
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
//        CustomCameraView()
        SelectStatusView()
    }
}


enum Status: String, CaseIterable {
    case gradient = "경사도, 턱 높음"
    case water = "좁은 길"
    case road = "자연재해"
    case natural = "공사중"
}

struct SelectStatusView: View {
    @State var selection: Status?
    var gridItem = [ GridItem(.flexible(), spacing: 10) ]
    var body: some View {
        VStack {
            Spacer()
            LazyVGrid(columns: gridItem) {
                ForEach(Status.allCases, id:  \.rawValue) { item in
                    Text(selection == item ? "🍎" + item.rawValue :  "🥚" + item.rawValue)
                        .frame(height: 60)
                        .onTapGesture {
                            selection = item
                        }
                }
                
                .frame(maxWidth: .infinity, alignment: .center)
                .background(.ultraThinMaterial)
                .cornerRadius(16)
                
            }
            .shadow(color: .black.opacity(0.15) ,radius: 4, x: 2, y: 2)
            .padding(.bottom, 100)
            
            HStack {
                Button {
                    //pop? binding
                } label: {
                    Text("러닝하기")
                }
                .frame(width: 100, height: 80)
                .background(.ultraThinMaterial)
                
                NavigationLink {
                    ReportSubmitView()
                } label: {
                    Text("제보하기")
                }
                .frame(width: 100, height: 80)
                .background(.ultraThinMaterial)
            }
            .padding(.bottom, 80)
        }
        .padding(.horizontal, 60)
    }
}
