//
//  WatchLocationManager.swift
//  SeSACTHON_Watch Watch App
//
//  Created by ChoiYujin on 2023/06/12.
//

import Foundation
import CoreLocation

class WatchLocationDataManager : NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var locationManager = CLLocationManager()
    @Published var authorizationStatus: CLAuthorizationStatus?
    
    @Published var currentLocation: CLLocationCoordinate2D = CLLocationCoordinate2D()
    @Published var address: String = ""
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.allowsBackgroundLocationUpdates = true
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways:
            authorizationStatus = .authorizedAlways
            locationManager.requestLocation()
            break
        case .authorizedWhenInUse:
            authorizationStatus = .authorizedWhenInUse
            locationManager.requestLocation()
            break
            
        case .restricted:
            authorizationStatus = .restricted
            break
            
        case .denied:
            authorizationStatus = .denied
            break
            
        case .notDetermined:
            authorizationStatus = .notDetermined
            manager.requestWhenInUseAuthorization()
            break
            
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        // Do something with the new location here
        self.currentLocation = manager.location?.coordinate ?? CLLocationCoordinate2D()
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let placemark = placemarks?.first {
                self.address = placemark.name ?? ""
            }
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
    
    func returnLocation() -> CLLocationCoordinate2D {
        return currentLocation
    }
}

