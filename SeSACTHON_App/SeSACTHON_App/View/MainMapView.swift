//
//  MainMapView.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/01.
//

import SwiftUI
import MapKit

struct MainMapView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.748433, longitude: 126.123), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    @State var userTrackingMode: MapUserTrackingMode = .follow
    
    var empireStateBuilding =
    PlaceMO(name: "지곡회관", coordinate: CLLocationCoordinate2D(latitude: 36.01577810316272, longitude: 129.32320658359848 ))
    
    var body: some View {
        VStack {
            
            VStack(spacing: 12) {
                Spacer().frame(height: 40)
                TopProfileView()
                Label("address", systemImage: "smallcircle.filled.circle")
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
                Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(userTrackingMode), annotationItems: [empireStateBuilding]
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

struct MainMapView_Previews: PreviewProvider {
    static var previews: some View {
        MainMapView()
    }
}


