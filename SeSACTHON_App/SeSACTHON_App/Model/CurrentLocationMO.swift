//
//  CurrentLocationMO.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/01.
//

import Foundation
import SwiftUI
import UIKit
import CoreLocation

class CurrentLocationMO: ObservableObject {
    static let shared = CurrentLocationMO()
    @Published var lat: CLLocationDegrees = 0
    @Published var long: CLLocationDegrees = 0
    private init() { }
}
