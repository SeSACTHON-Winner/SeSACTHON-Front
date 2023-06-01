//
//  MapSearchView.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/01.
//

import SwiftUI
import MapKit

struct MapSearchView: View {
    
    @Binding var searchText: String
    @StateObject private var completerWrapper = LocalSearchCompleterWrapper()
    
    var body: some View {
        VStack(spacing: 12) {
            Label("주소들어가는자리", systemImage: "smallcircle.filled.circle")
                .padding(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 36)
                .background(Color.white)
                .cornerRadius(10)
            
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("검색하는 곳", text: $searchText)
                    .onChange(of: searchText) { newValue in
                        completerWrapper.search(query: newValue)
                    }
            }
            .padding(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 36)
            .background(Color.white)
            .cornerRadius(10)
            
            if !completerWrapper.searchResults.isEmpty && searchText != "" {
                List(completerWrapper.searchResults, id: \.self) { result in
                    Text(result.title)
                        .onTapGesture {
                            handleSearchResultTapped(result)
                            completerWrapper.searchResults.removeAll()
                        }
                }
                .listStyle(.plain)
                .frame(height: 160)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.black)
    }
    
    private func handleSearchResultTapped(_ completion: MKLocalSearchCompletion) {
        // Perform the desired action when a search result is tapped
        print("Selected search result: \(completion.title)")
        // Clear the search text and dismiss the keyboard
        searchText = ""
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct MapSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MapSearchView(searchText: .constant("포항"))
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
