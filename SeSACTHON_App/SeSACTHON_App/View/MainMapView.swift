//
//  MainMapView.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/01.
//

import SwiftUI
import MapKit

struct MainMapView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.748433, longitude: 126.123), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    @State var userTrackingMode: MapUserTrackingMode = .follow
    
    @State var placeMOArr: [PlaceMO] = [PlaceMO(name: "지곡회관", coordinate: CLLocationCoordinate2D(latitude: 36.01577810316272, longitude: 129.32320658359848)), PlaceMO(name: "dd", coordinate: CLLocationCoordinate2D(latitude: 36.016, longitude: 129.324))
    ]
    @ObservedObject var locationManager = LocationDataManager()
    
    var body: some View {
        VStack {
            
            VStack(spacing: 12) {
                Spacer().frame(height: 40)
                TopProfileView()
                Label(locationManager.address, systemImage: "smallcircle.filled.circle")
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 36)
                    .background(Color.white)
                    .cornerRadius(10)
                    .labelStyle(MintSystemImageLabelStyle())
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.black)
            .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
            ZStack {
                Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(userTrackingMode), annotationItems: placeMOArr
                ) { place in
                    MapAnnotation(coordinate: place.coordinate) {
                        PlaceAnnotationView()
                    }
                }
                .gesture(DragGesture().onChanged { _ in
                    userTrackingMode = .none
                })
                .tint(.mint)
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            if userTrackingMode == .none {
                                userTrackingMode = .follow
                            }
                        } label: {
                            Image("CurrentLocationBtn").frame(width: 50, height: 50)
                        }
                    }
                    .padding(40)
                }
            }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
    }
}

extension MainMapView {
    
    func fetchAnnotationItems() {
        // API가 완성되면 여기에 호출 코드 작성
    }
    
    
}

struct MainMapView_Previews: PreviewProvider {
    static var previews: some View {
        MainMapView()
    }
}


