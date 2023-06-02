//
//  CurrentLocationMO.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/02.
//

import Foundation
import MapKit

class CurrentLocationMO: ObservableObject {
    @Published var currentLocation: CLLocationCoordinate2D
    
    init(currentLocation: CLLocationCoordinate2D) {
        self.currentLocation = currentLocation
    }
}
