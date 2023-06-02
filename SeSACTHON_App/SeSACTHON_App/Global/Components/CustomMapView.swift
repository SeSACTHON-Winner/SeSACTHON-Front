//
//  CustomMapView.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/01.
//

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
    }
}
//
//struct CustomMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomMapView(userTrackingMode: .constant(.follow), )
//    }
//}
