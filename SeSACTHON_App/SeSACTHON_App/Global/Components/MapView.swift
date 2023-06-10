//
//  MapView.swift
//  Running
//
//  Created by Ah lucie nous gênes 🍄 on 19/02/2023.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @EnvironmentObject var vm: WorkoutViewModel
    @Binding var region: MKCoordinateRegion

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        
        mapView.delegate = vm
        vm.mapView = mapView
        mapView.showsUserLocation = true
       // mapView.setUserTrackingMode(.followWithHeading, animated: false)
        mapView.showsScale = true
        mapView.showsCompass = true
        mapView.isPitchEnabled = false
        mapView.region = region
        
        let tapRecognizer = UITapGestureRecognizer(target: vm, action: #selector(WorkoutViewModel.handleTap))
        mapView.addGestureRecognizer(tapRecognizer) // 맵 뷰에 탭 제스처 인식기를 추가
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {}
}
