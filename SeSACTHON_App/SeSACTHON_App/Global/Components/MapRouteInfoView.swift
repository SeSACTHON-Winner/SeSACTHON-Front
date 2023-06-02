//
//  MapRouteInfoView.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/01.
//

import SwiftUI

struct MapRouteInfoView: View {
    
    
    @Binding var address: String
    @Binding var formattedTime: String
    @Binding var formattedDistance: String
    
    var body: some View {
        VStack(spacing: 12) {
            
            Label(address, systemImage: "paperplane.fill")
                .labelStyle(BlueSystemImageLabelStyle())
                .padding(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 36)
                .background()
                .cornerRadius(10)
            
            HStack {
                Spacer()
                VStack {
                    Text(formattedTime)
                        .font(.custom("SF Pro Text", size: 24))
                        .foregroundColor(.white)
                        .italic()
                    Text("경사도구간")
                }
                Spacer()
                VStack {
                    Text("3")
                        .font(.custom("SF Pro Text", size: 24))
                        .foregroundColor(.white)
                        .italic()
                    Text("장애물")
                }
                Spacer()
                VStack {
                    Text(formattedDistance)
                        .font(.custom("SF Pro Text", size: 24))
                        .foregroundColor(.white)
                        .italic()
                    Text("예정시간")
                }
                Spacer()
            }
            .foregroundColor(.white)
            .padding(.bottom, 24)
            
            
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.black)
        .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
    }
}

//struct MapRouteInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapRouteInfoView()
//    }
//}
