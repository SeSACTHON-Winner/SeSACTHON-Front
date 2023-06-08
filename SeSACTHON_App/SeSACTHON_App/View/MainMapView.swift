//
//  MainMapView.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/01.
//

import SwiftUI
import MapKit
import Foundation

struct MainMapView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.748433, longitude: 126.123), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    @State var userTrackingMode: MapUserTrackingMode = .follow
    
    @State var placeMOArr: [PlaceMO] = []
    @ObservedObject var locationManager = LocationDataManager()
    @State var searchText = ""
    @StateObject private var completerWrapper = LocalSearchCompleterWrapper()
    @State var isPlaceSelected: Bool = false
    @State var address: String = ""
    
    var body: some View {
        VStack {
            
            VStack(spacing: 12) {
                Spacer().frame(height: 40)
                TopProfileView(title: "MAP")
                Label(locationManager.address, systemImage: "smallcircle.filled.circle")
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 36)
                    .background(Color.white)
                    .cornerRadius(10)
                    .labelStyle(MintSystemImageLabelStyle())
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("검색하는 곳", text: $searchText)
                        .onChange(of: searchText) { newValue in
                            userTrackingMode = .none
                            completerWrapper.search(query: newValue)
                        }
                }
                .padding(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 36)
                .background(Color.white)
                .cornerRadius(10)
                .padding(.bottom, 18)
                if !completerWrapper.searchResults.isEmpty && searchText != "" {
                    List(completerWrapper.searchResults, id: \.self) { result in
                        Button {
                            handleSearchResultTapped(result)
                        } label: {
                            Text(result.title)
                        }
                    }
                    .listStyle(.plain)
                    .frame(height: 160)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.black)
            .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
            ZStack {
                Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(userTrackingMode), annotationItems: placeMOArr
                ) { place in
                    MapAnnotation(coordinate: place.coordinate) {
                        PlaceAnnotationView()
                    }
                }
                .gesture(DragGesture().onChanged { _ in
                    userTrackingMode = .none
                })
                .tint(.mint)
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            if userTrackingMode == .none {
                                userTrackingMode = .follow
                            }
                        } label: {
                            Image("CurrentLocationBtn").frame(width: 50, height: 50)
                        }
                    }
                    .padding(40)
                }
            }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .onAppear {
            self.placeMOArr = fetchAnnotationItems()
        }
    }
}

extension MainMapView {
    
    func getAddressFromCoordinates() {
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: region.center.latitude, longitude: region.center.longitude)
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Reverse geocoding error: \(error.localizedDescription)")
            } else if let placemark = placemarks?.first {
                // Extract the desired address information from the placemark
                let address = "\(placemark.subThoroughfare ?? "") \(placemark.thoroughfare ?? ""), \(placemark.locality ?? "")"
                self.address = address
            }
        }
    }
    
    private func handleSearchResultTapped(_ completion: MKLocalSearchCompletion) {
        let searchRequest = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: searchRequest)
        search.start { response, error in
            guard let mapItem = response?.mapItems.first else {
                // Handle error
                return
            }
            
            let coordinate = mapItem.placemark.coordinate
            print("Selected search result: \(completion.title)")
            print("Coordinate: \(coordinate)")
            
            // Perform additional actions with the coordinate if needed
            searchText = ""
            completerWrapper.searchResults.removeAll()
            isPlaceSelected = true
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude:  coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.00001, longitudeDelta: 0.00001))
            getAddressFromCoordinates()
            
            // Clear the search text and dismiss the keyboard
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    
}

struct MainMapView_Previews: PreviewProvider {
    static var previews: some View {
        MainMapView()
    }
}


class LocalSearchCompleterWrapper: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    @Published var searchResults: [MKLocalSearchCompletion] = []
    private let completer = MKLocalSearchCompleter()
    
    override init() {
        super.init()
        completer.delegate = self
    }
    
    func search(query: String) {
        completer.queryFragment = query
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
    }
}


