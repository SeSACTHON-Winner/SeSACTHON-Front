//
//  MainRunView.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/01.
//

import SwiftUI
import MapKit

struct MainRunView: View {
    
    @State var searchText = ""
    @State var showRoute = false
    @State var isPlaceSelected = false
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    @State var address = ""
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    let layout = [
        GridItem(.flexible())
    ]
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
           
                CustomMapView(userTrackingMode: self.$userTrackingMode, region: self.$region)
                    .ignoresSafeArea()
            }
            
            
            VStack {
                Spacer().frame(height: 128)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows:layout, spacing: 20) {
                        ForEach(0...2, id: \.self) { _ in
                            HStack {
                                HStack(spacing: 20) {
                                    Image(systemName: "pause.fill")
                                        .resizable()
                                        .padding(16)
                                        .foregroundColor(.blue)
                                    
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
                                        
                                        Text("3.3km/30분")
                                            .font(.system(size: 14, weight: .regular))
                                        
                                    }.foregroundColor(.white)
                                    Spacer()
                                }.padding(20)
                            }.frame(width: 312, height: 124)
                                .background(.black)
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal, 40)
                }
                Spacer()
                HStack(alignment: .top, spacing: 28) {
                    Button {
                        //
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .foregroundColor(.black)
                            .frame(width: 52, height: 52)
                            .shadow(radius: 2)
                    }
                    
                    NavigationLink {
                        //커스텀 카메라 뷰로 임시 연결
                        CustomCameraView()
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
    }
}

struct MainRunView_Previews: PreviewProvider {
    static var previews: some View {
        MainRunView()
    }
}
