//
//  CustomMapView.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/04.
//

import SwiftUI

import SwiftUI
import MapKit

struct CustomMapView: View {
    @StateObject var locationDataManager = LocationDataManager()
    @Binding var userTrackingMode: MapUserTrackingMode
    @Binding var region: MKCoordinateRegion
    
    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(userTrackingMode))
            .gesture(DragGesture().onChanged { _ in
                userTrackingMode = .none
            })
            .tint(.sesacMint)
    }
}
