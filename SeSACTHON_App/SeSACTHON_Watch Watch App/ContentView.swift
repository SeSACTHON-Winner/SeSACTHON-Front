//
//  ContentView.swift
//  SeSACTHON_Watch Watch App
//
//  Created by ChoiYujin on 2023/06/04.
//

import SwiftUI

struct ContentView: View {
    
    @State var scrollAmount = 0.0
    
    var body: some View {
        ScrollView {
            VStack {
                Text("5 : 12 : 48")
                    .font(.custom("SF Pro Text", size: 24))
                    .foregroundColor(.white)
                    .italic()
                Button {
                    print("경사도 턱 높음")
                } label: {
                    Text("경사도 턱 높음")
                }
                Button {
                    print("좁은길")
                } label: {
                    Text("좁은길")
                }
                Button {
                    print("자연재해")
                } label: {
                    Text("자연재해")
                }
                Button {
                    print("공사중")
                } label: {
                    Text("공사중")
                }
                
            }
            
            .padding()
        }
        .focusable(true)
        .digitalCrownRotation($scrollAmount)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
