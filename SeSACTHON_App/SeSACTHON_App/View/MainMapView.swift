//
//  MainMapView.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/01.
//

import SwiftUI
import MapKit
import Alamofire
import Kingfisher

struct MainMapView: View {
    
    var mainUUID = FocusUUID()
    var mapUUID = UUID()
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.748433, longitude: 126.123), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    @State var userTrackingMode: MapUserTrackingMode = .follow
    @ObservedObject var locationManager = LocationDataManager()
    @State var searchText = ""
    @StateObject private var completerWrapper = LocalSearchCompleterWrapper()
    @State var isPlaceSelected: Bool = false
    @State var address: String = ""
    @State var dangerArr: [DangerInfoMO] = []
    @Environment(\.dismiss) private var dismiss
    @State var dangerGroupArr: [DangerInfoGroup] = []
    @State var imagePath = "images/default.png"
    
    @EnvironmentObject var vm: WorkoutViewModel

    
    var body: some View {
            VStack {
                
                VStack(spacing: 12) {
                    Spacer().frame(height: 40)
                    HStack {
                        Button {
                            dangerArr.removeAll()
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.backward")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 10, height: 16)
                                .foregroundColor(.white)
                                .padding(.trailing, 10)
                        }
                        Text("MAP")
                            .font(.custom("SF Pro Text", size: 32))
                            .foregroundColor(.white)
                            .italic()
                        Spacer()
                        Button {
                            vm.showRunListView = true
                        } label: {
                            KFImage(URL(string: "http://35.72.228.224/sesacthon/\(imagePath)")!)
                                .placeholder { //플레이스 홀더 설정
                                    Image(systemName: "map")
                                }.retry(maxCount: 3, interval: .seconds(5)) //재시도
                                .onSuccess {r in //성공
                                    print("succes: \(r)")
                                }
                                .onFailure { e in //실패
                                    print("failure: \(e)")
                                }
                                .resizable()
                                .frame(width: 34, height: 34)
                                .clipShape(Circle())
                                .padding(.leading)
                            
                        }
                      
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom)
                    .background(.black)

                    HStack {
                        Image(systemName: "magnifyingglass")
                        
                        if isPlaceSelected {
                            TextField(locationManager.address, text: $address)
                                .onChange(of: searchText) { newValue in
                                    userTrackingMode = .none
                                    completerWrapper.search(query: newValue)
                                }
                        } else {
                            TextField(locationManager.address, text: $searchText)
                                .onChange(of: searchText) { newValue in
                                    userTrackingMode = .none
                                    completerWrapper.search(query: newValue)
                                }
                        }
                    }
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 36)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.bottom, 8)
                    if !completerWrapper.searchResults.isEmpty && searchText != "" {
                        List(completerWrapper.searchResults, id: \.self) { result in
                            Button {
                                handleSearchResultTapped(result)
                                address = result.title
                                isPlaceSelected = true
                            } label: {
                                Text(result.title)
                            }
                        }
                        .listStyle(.plain).cornerRadius(12)
                        .frame(height: 160)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.black)
                .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
                .shadow(radius: 3, x: 0 ,y: 4)

                
                ZStack {
                    Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(userTrackingMode), annotationItems: dangerGroupArr
                    ) { danger in
                        MapAnnotation(coordinate: .init(latitude: danger.latitude_mod, longitude: danger.longitude_mod)) {
                            PlaceAnnotationView.init(danger: danger)
                                .onLongPressGesture {
                                    withAnimation(.easeIn(duration: 0.4)) {
                                        self.region.center.latitude = danger.latitude_mod
                                        self.region.center.longitude = danger.longitude_mod
                                    }
                                }
                                .environmentObject(mainUUID)
                        }
                    }
                    .gesture(DragGesture().onChanged { _ in
                        userTrackingMode = .none
                        mainUUID.focusUUID = mapUUID
                    })
                    .tint(.mint)
                    
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button {
                                if userTrackingMode == .none {
                                    userTrackingMode = .follow
                                    isPlaceSelected = false
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
            print("fetchDangerList() : \(fetchDangerList())")
//            self.dangerArr = fetchDangerList()
            fetchAnnotationItems()
            print("dangerArr \(dangerArr)")
            var url = URL(string: "http://35.72.228.224/sesacthon/profileImage.php")!
            let params = ["uid" : UserDefaults.standard.string(forKey: "uid")] as Dictionary
            AF.request(url, method: .get, parameters: params).responseString { picturePath in
                print(picturePath)
                self.imagePath = picturePath.value ?? "images/default.png"
            }
            print("KFImage : \(GlobalProfilePath.picture_path)")
        }
        .fullScreenCover(isPresented: $vm.showRunListView, content: {
            ProfileView()
        })
    }
}

extension MainMapView {
    
    func fetchAnnotationItems() {
        // API가 완성되면 여기에 호출 코드 작성
        
        self.dangerArr.removeAll()
        AF.request("http://35.72.228.224/sesacthon/dangerInfo.php")
            .responseDecodable(of: [DangerInfoMO].self) { response in
                guard let dangerInfoArray = response.value else {
                    print("Failed to decode dangerInfoArray")
                    return
                }
                
                for mo in response.value! {
                    print("mo : \(mo)")
                }
                
                print(response.value?.first?.latitude)
                dangerArr = response.value!
                print(dangerArr.description)
                
                //
                for one in dangerArr {
                    print("dangerGroup 만들기 실행")
                    var la = floor(one.latitude*10000)/10000
                    var lo = floor(one.longitude*10000)/10000
                    if dangerGroupArr.isEmpty{
                        var temp = DangerInfoGroup.init(latitude_mod: la, longitude_mod: lo)
                        temp.list.append(one)
                        dangerGroupArr.append(temp)
                    }
                    else{
                        var flag = true
                        for groupOne in dangerGroupArr {
                            if groupOne.latitude_mod == la && groupOne.longitude_mod == lo {
                                groupOne.list.append(one)
                                flag = false
                                break
                            }
                        }
                        if flag {
                            var temp = DangerInfoGroup.init(latitude_mod: la, longitude_mod: lo)
                            temp.list.append(one)
                            dangerGroupArr.append(temp)
                        }
                    }
                    
                }
                //
            }
        return
    }
    
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
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude:  coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
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


