//
//  MainMapView.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/01.
//

import SwiftUI
import MapKit

struct MainMapView: View {

    @State var searchText = ""
    @State var showRoute = false
    @State var isPlaceSelected = false
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    @State var address = ""
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

    var body: some View {

        ZStack {
            VStack(spacing: 0) {
                if showRoute {
                    MapRouteInfoView()
                } else {
                    MapSearchView(searchText: self.$searchText, isPlaceSelected: self.$isPlaceSelected, address: self.$address, region: self.$region)
                }
                CustomMapView(userTrackingMode: self.$userTrackingMode, region: self.$region)
                    .ignoresSafeArea()
            }

            VStack {
                Spacer()

                HStack(alignment: .top) {
                    Image("GoBtn")
                        .padding(.bottom, 94)
                        .padding(.leading, UIScreen.main.bounds.size.width / 2 - 120)
                        .onTapGesture {
                            withAnimation(.easeOut(duration: 0.4)) {
                                searchText = ""
                                showRoute = true
                                isPlaceSelected = false
                            }
                        }
                    Image("CurrentLocationBtn")
                        .padding(.bottom, 94)
                        .onTapGesture {
                            withAnimation(.easeOut(duration: 0.4)) {
                                userTrackingMode = .follow
                            }
                        }
                }
            }
            .frame(maxWidth: .infinity)
            .opacity(isPlaceSelected ? 1 : 0)
            if showRoute {
                VStack {
                    Spacer()
                    HStack(alignment: .top) {
                        Image("EndMintBtn")
                            .padding(.bottom, 94)
                            .onTapGesture {
                                withAnimation(.easeOut(duration: 0.4)) {
                                    searchText = ""
                                    showRoute = false
                                }
                            }
                    }
                }
                .frame(maxWidth: .infinity)
                .opacity(showRoute ? 1 : 0)
            }
        }
        .frame(maxWidth: .infinity)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.keyboard)

    }
}

struct MainMapView_Previews: PreviewProvider {
    static var previews: some View {
        MainMapView()
    }
}

