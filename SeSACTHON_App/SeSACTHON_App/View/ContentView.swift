//
//  ContentView.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/05/31.
//

import SwiftUI

struct ContentView: View {
    
    @State var isAnythingClicked = false
    @State var leftTabColor = Color.black
    @State var rightTabColor = Color.white
    @State var leftTextColor = Color.white
    @State var rightTextColor = Color.black
    @State var isLeftClicked = true
    
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                HStack(spacing: 0) {
                    ZStack {
                        leftTabColor
                            .ignoresSafeArea()
                        Text("Map")
                            .font(.system(size: 75, weight: .heavy))
                            .foregroundColor(leftTextColor)
                            .italic()
                    }
                    .onTapGesture {
                        isAnythingClicked = true
                        leftTabColor = .black
                        rightTabColor = .white
                        leftTextColor = .mint
                        rightTextColor = .black
                        isLeftClicked = true
                        UserDefaults().setValue(true, forKey: "isMap")
                        UserDefaults().setValue(false, forKey: "isRun")
                        
                    }
                    ZStack{
                        rightTabColor
                            .ignoresSafeArea()
                        Text("Run")
                            .font(.system(size: 75, weight: .heavy))
                            .foregroundColor(rightTextColor)
                            .italic()
                    }
                    .onTapGesture {
                        isAnythingClicked = true
                        leftTabColor = .white
                        rightTabColor = .black
                        leftTextColor = .black
                        rightTextColor = .mint
                        isLeftClicked = false
                        UserDefaults().setValue(false, forKey: "isMap")
                        UserDefaults().setValue(true, forKey: "isRun")
                    }
                }
                VStack {
                    Spacer()
                    NavigationLink {
                        if isLeftClicked {
                            MainMapView()
                        } else {
                            MainRunView()
                        }
                    } label: {
                        Image(isLeftClicked ? "MainGoRight" : "MainGoLeft")
                            .opacity(isAnythingClicked ? 1 : 0)
                    }
                }
                
            }
        }
        .onAppear {
            if UserDefaults().bool(forKey: "isMap") {
                isAnythingClicked = true
                leftTabColor = .black
                rightTabColor = .white
                leftTextColor = .mint
                rightTextColor = .black
                isLeftClicked = true
            } else if UserDefaults().bool(forKey: "isRun") {
                isAnythingClicked = true
                leftTabColor = .white
                rightTabColor = .black
                leftTextColor = .black
                rightTextColor = .mint
                isLeftClicked = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
