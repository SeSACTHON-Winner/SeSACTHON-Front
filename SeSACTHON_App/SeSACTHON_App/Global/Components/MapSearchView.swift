//
//  MapSearchView.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/01.
//

import SwiftUI

struct MapSearchView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        VStack(spacing: 12) {
            
            Label("주소들어가는자리", systemImage: "smallcircle.filled.circle")
                .padding(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 36)
                .background()
                .cornerRadius(10)
            
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("검색하는 곳", text: $searchText)
            }
            .padding(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 36)
            .background()
            .cornerRadius(10)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.black)
    }
}

//struct MapSearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapSearchView()
//    }
//}
