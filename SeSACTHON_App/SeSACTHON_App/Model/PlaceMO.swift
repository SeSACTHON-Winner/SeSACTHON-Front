//
//  PlaceMO.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/04.
//

import Foundation
import MapKit

struct PlaceMO: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}
