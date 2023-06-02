//
//  MapRouteInfoView.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/01.
//

import SwiftUI

struct MapRouteInfoView: View {
    
    var body: some View {
        VStack(spacing: 12) {
            
            Label("포항시 대이동", systemImage: "smallcircle.filled.circle")
                .padding(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 36)
                .background()
                .cornerRadius(10)
            
            HStack {
                Spacer()
                VStack {
                    Text("7m")
                        .font(.custom("SF Pro Text", size: 48))
                        .foregroundColor(.white)
                        .italic()
                    Text("경사도구간")
                }
                Spacer()
                VStack {
                    Text("3")
                        .font(.custom("SF Pro Text", size: 48))
                        .foregroundColor(.white)
                        .italic()
                    Text("장애물")
                }
                Spacer()
                VStack {
                    Text("15m")
                        .font(.custom("SF Pro Text", size: 48))
                        .foregroundColor(.white)
                        .italic()
                    Text("예정시간")
                }
                Spacer()
            }
            .foregroundColor(.white)
            
            
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.black)
    }
}

struct MapRouteInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MapRouteInfoView()
    }
}
