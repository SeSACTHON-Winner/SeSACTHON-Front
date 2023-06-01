//
//  ContentView.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/05/31.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationStack {
            HStack(spacing: 30) {
                NavigationLink {
                    MainMapView()
                } label: {
                    Text("Map으로 이동")
                }
                NavigationLink {
                    MainRunView()
                } label: {
                    Text("Run으로 이동")
                }

            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
