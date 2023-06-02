//
//  NavigationMapView.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/02.
//

import SwiftUI
import MapKit

struct NavigationMapView: UIViewRepresentable {
    
    // Define the starting and ending locations
    let sourceLocation: CLLocationCoordinate2D
    let destinationLocation: CLLocationCoordinate2D
    @Binding var region: MKCoordinateRegion
    
    func makeUIView(context: UIViewRepresentableContext<NavigationMapView>) -> MKMapView {
        let map = MKMapView()
        
        let sourcePin = MKPointAnnotation()
        sourcePin.coordinate = self.sourceLocation
        sourcePin.title = "출발"
        map.addAnnotation(sourcePin)
        
        
        
        let destinationPin = MKPointAnnotation()
        destinationPin.coordinate = self.destinationLocation
        destinationPin.title = "도착"
        map.addAnnotation(destinationPin)
        
        // Set the region to show both source and destination
        let region = MKCoordinateRegion(center: destinationLocation, span: MKCoordinateSpan(latitudeDelta: 0.00001, longitudeDelta: 0.00001))
        map.region = region
        map.delegate = context.coordinator
        
        let req = MKDirections.Request()
        req.source = MKMapItem(placemark: MKPlacemark(coordinate: sourceLocation))
        req.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationLocation))
        req.transportType = .walking
        let directions = MKDirections(request: req)
        
        directions.calculate { direct, err in
            if let error = err {
                print(error.localizedDescription)
                return
            }
            
            DispatchQueue.main.async {
                let polyline = direct?.routes.first?.polyline
                map.addOverlay(polyline!, level: .aboveRoads)
                map.setRegion(MKCoordinateRegion(polyline!.boundingMapRect), animated: true)
            }
        }
        
        return map
    }
    
    
    func updateUIView(_ view: MKMapView, context: UIViewRepresentableContext<NavigationMapView>) {
        
    }
    
    // Configure the route polyline overlay
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 5
        return renderer
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: NavigationMapView
        
        init(_ parent: NavigationMapView) {
            self.parent = parent
        }
        
        // Implement the delegate method
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            return nil
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let render = MKPolylineRenderer(overlay: overlay)
            render.strokeColor = .black
            render.lineWidth = 3
            return render
        }
    }
}

