//
//  MainMapView.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/01.
//

import SwiftUI

struct MainMapView: View {

    @State var searchText = ""
    @State var showRoute = false

    var body: some View {

        ZStack {
            VStack(spacing: 0) {
                if showRoute {
                    MapRouteInfoView()
                } else {
                    MapSearchView(searchText: self.$searchText)
                }
                CustomMapView()
                    .ignoresSafeArea()
            }

            VStack {
                Spacer()

                HStack(alignment: .top) {
                    Image("GoBtn")
                        .padding(.bottom, 94)
                        .padding(.leading, UIScreen.main.bounds.size.width / 2 - 120)
                        .onTapGesture {
                            withAnimation(.easeOut(duration: 0.4)) {
                                searchText = ""
                                showRoute = true
                            }
                        }
                    Image("CurrentLocationBtn")
                        .padding(.bottom, 94)
                        .onTapGesture {
                            withAnimation(.easeOut(duration: 0.4)) {
                                searchText = ""
                                showRoute = true
                            }
                        }
                }
            }
            .frame(maxWidth: .infinity)
            .opacity(searchText != "" ? 1 : 0)
            if showRoute {
                VStack {
                    Spacer()
                    HStack(alignment: .top) {
                        Image("EndMintBtn")
                            .padding(.bottom, 94)
                            .onTapGesture {
                                withAnimation(.easeOut(duration: 0.4)) {
                                    searchText = ""
                                    showRoute = false
                                }
                            }
                    }
                }
                .frame(maxWidth: .infinity)
                .opacity(showRoute ? 1 : 0)
            }
        }
        .frame(maxWidth: .infinity)
        .navigationBarBackButtonHidden(true)

    }
}

struct MainMapView_Previews: PreviewProvider {
    static var previews: some View {
        MainMapView()
    }
}

