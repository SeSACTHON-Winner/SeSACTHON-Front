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
                
                HStack{
                    // 찍은 사진 미리보기
                    Button(action: {}) {
                        // ✅ view 추가
                        if let previewImage = viewModel.recentImage {
                            Image(uiImage: previewImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 75, height: 75)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .aspectRatio(1, contentMode: .fit)
                        } else {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(lineWidth: 3)
                                .foregroundColor(.white)
                                .frame(width: 75, height: 75)
                        }
                    }
                    .padding()
                    
                    Spacer()
                    
                    // 사진찍기 버튼
                    NavigationLink {
                        SelectStatusView()
                    } label: {
                        Circle()
                            .stroke(lineWidth: 5)
                            .frame(width: 75, height: 75)
                            .padding()
                    }.onTapGesture {
                        viewModel.capturePhoto()
                    }
                    
                    Spacer()
                    
                    // 전후면 카메라 교체
                    Button(action: {viewModel.changeCamera()}) {
                        Image(systemName: "arrow.triangle.2.circlepath.camera")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        
                    }
                    .frame(width: 75, height: 75)
                    .padding()
                }
            }
            .foregroundColor(.white)
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CustomCameraView()
    }
}


enum Status: String, CaseIterable {
    case gradient
    case water
    case road
    case natural
}

struct SelectStatusView: View {
    @State var selection: Status?
    var gridItem = [ GridItem(.flexible(), spacing: 16) ]
    var body: some View {
        VStack {
            Spacer()
            LazyVGrid(columns: gridItem) {
                ForEach(Status.allCases, id:  \.rawValue) { item in
                   
                    Text("🍎" + item.rawValue)
                        .frame(height: 60)
                       
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .background(.ultraThinMaterial)
                .cornerRadius(16)
            }
            .shadow(color: .black.opacity(0.15) ,radius: 4, x: 2, y: 2)
            .padding(.bottom, 100)
            
            
            HStack {
//                Button {
//                    //pop? binding으로
//                    //아님 네비게이션 링크로 다시 찍게 할까
//                } label: {
//                    Text("다시 찍기")
//                        .background(.ultraThinMaterial)
//                }

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
        .padding(.horizontal, 16)
    }
}
