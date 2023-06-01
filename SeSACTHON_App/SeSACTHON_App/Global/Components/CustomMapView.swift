//
//  CustomMapView.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/01.
//

import SwiftUI
import MapKit

struct CustomMapView: View {
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.5666791, longitude: 126.9782914), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

    
    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow))
    }
}

struct CustomMapView_Previews: PreviewProvider {
    static var previews: some View {
        CustomMapView()
    }
}
