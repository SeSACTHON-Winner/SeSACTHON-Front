//
//  MainRunningView.swift
//  SeSACTHON_App
//
//  Created by Lee Jinhee on 2023/06/05.
//

import SwiftUI

struct MainRunningView: View {
    @Binding var swpSelection: Int
   // @State private var startCount = "3."
    
    var body: some View {
        VStack {
            VStack {
                Spacer().frame(height: 60)
                HStack {
                    Text("00 : 00 : 00").foregroundColor(.white)
                        .font(.system(size: 48, weight: .black)).italic()
                    Spacer()
                }.padding(.leading, 28)
            }
            .foregroundColor(.white)
            .frame(height: 120)
            .frame(maxWidth: .infinity)
            .background(Color.black)
            .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
            .shadow(color: .black.opacity(0.25),radius: 4, x: 0, y: 4)
            
            Spacer()
            Button {
                swpSelection = 3
            } label: {
                Text("Stop")
                    .font(.system(size: 28, weight: .black))
                    .italic()
                    .foregroundColor(.white)
                    .frame(width: 120, height: 120)
                    .background(.black)
                    .cornerRadius(60)
            }.padding(.bottom, 60)
            
        }.edgesIgnoringSafeArea(.all)
    }
}
struct MainRunningView_Previews: PreviewProvider {
    static var previews: some View {
        MainRunningView(swpSelection: .constant(2))
    }
}
