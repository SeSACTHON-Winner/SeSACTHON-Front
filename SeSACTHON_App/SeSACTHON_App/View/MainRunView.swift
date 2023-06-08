//
//  MainRunView.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/01.
//

import SwiftUI
import MapKit

struct MainRunView: View {
    @State private var swpSelection = 0
    //var healthDataManager = HealthDataManager()
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    var body: some View {
        ZStack {
            switch swpSelection {
            case 0, 1, 2:
                VStack(spacing: 0) {
                    CustomMapView(userTrackingMode: self.$userTrackingMode, region: self.$region)
                        .ignoresSafeArea()
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
                //MainRunningView(swpSelection: $swpSelection)
                RootView()
            case 3:
                RunEndView(swpSelection: $swpSelection)
            default:
                EmptyView()
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            //healthDataManager.requestHealthAuthorization()
        }
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
            .padding(.bottom, 60)
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
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                CustomMapView(userTrackingMode: self.$userTrackingMode, region: self.$region)
                    .ignoresSafeArea()
            }
            VStack(spacing: 0) {
                Color.black.frame(height: 40)
                TopProfileView(title: "RUN")
                    .padding(.horizontal, 20)
                    .background(.black)
                HStack {
                    Image(systemName: "location.fill")
                        .resizable()
                        .foregroundColor(.blue)
                        .frame(width: 20, height: 20)
                    Text("출발 위치 : 효성로 17번길 21 - 13").foregroundColor(.white)
                        .font(.system(size: 17, weight: .regular))
                }
                .foregroundColor(.white)
                .frame(height: 96)
                .frame(maxWidth: .infinity)
                .background(Color.black)
                .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
                .shadow(color: .black.opacity(0.25),radius: 4, x: 0, y: 4)
                
                Spacer().frame(height: 130)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows:layout, spacing: 20) {
                        ForEach(0...2, id: \.self) { _ in
                            HStack {
                                HStack(spacing: 20) {
                                    Image(systemName: "map.fill")
                                        .resizable()
                                        .padding(16)
                                        .foregroundColor(.black)
                                        .frame(width: 82, height: 82)
                                        .background(.white)
                                        .cornerRadius(8)
                                    
                                    //TODO: 데이터 연결
                                    VStack(alignment: .leading) {
                                        Text("오전동")
                                            .font(.system(size: 10, weight: .regular))
                                        Spacer().frame(height: 16)
                                        Text("최근 기록")
                                            .font(.system(size: 20, weight: .semibold))
                                        Text("3.3km 40min")
                                            .font(.system(size: 14, weight: .regular))
                                        
                                    }.foregroundColor(.white)
                                    Spacer()
                                }.padding(20)
                            }.frame(width: 312, height: 124)
                                .background(Color("Darkgray"))
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal, 40)
                }
                Spacer()
                NavigationLink {
                    CustomCameraView()
                } label: {
                    Image(systemName: "bell.fill")
                        .font(.system(size: 28, weight: .black))
                        .italic()
                        .foregroundColor(.black)
                        .frame(width: 52, height: 52)
                        .background(Color("MainColor"))
                        .cornerRadius(26)
                        .shadow(color: .black.opacity(0.25), radius: 2)
                    
                }.padding(.bottom, 14)
                
                HStack(alignment: .top, spacing: 28) {
                    NavigationLink {
                        //SettingView()
                    } label: {
                        Image(systemName: "gearshape")
                            .font(.system(size: 28, weight: .black))
                            .italic()
                            .foregroundColor(.black)
                            .frame(width: 52, height: 52)
                            .background(Color("MainColor"))
                            .cornerRadius(26)
                            .shadow(color: .black.opacity(0.25), radius: 2)
                    }
                    
                    Button {
                        swpSelection = 1
                    } label: {
                        Text("Go")
                            .font(.system(size: 32, weight: .black))
                            .italic()
                            .foregroundColor(.white)
                            .frame(width: 120, height: 120)
                            .background(.black)
                            .cornerRadius(60)
                    }
                    
                    Button {
                        //
                    } label: {
                        Image(systemName: "location.circle.fill")
                            .resizable()
                            .foregroundColor(.black)
                            .frame(width: 52, height: 52)
                            .shadow(radius: 2)
                    }
                }.padding(.bottom, 60)
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .edgesIgnoringSafeArea(.top)
    }
}

struct MainRunView_Previews: PreviewProvider {
    static var previews: some View {
        MainRunView()
    }
}
