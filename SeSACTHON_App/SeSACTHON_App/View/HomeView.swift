//
//  HomeView.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/05.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.dismiss) private var dismiss
    @State var gotoRun = false
    
    var body: some View {
        VStack(spacing: 0) {
            Color.black.frame(height: 50)
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10, height: 16)
                        .foregroundColor(.white)
                        .padding(.trailing, 10)
                    
                }
                Text("Home")
                    .font(.custom("SF Pro Text", size: 32))
                    .foregroundColor(.white)
                    .italic()
                Spacer()
                NavigationLink {
                    ProfileView()
                } label: {
                    Image("Camera")
                        .resizable()
                        .frame(width: 34, height: 34)
                        .padding(.leading)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom)
            .padding(.horizontal)
            .background(.black)
            Color.black.frame(height: 40)
                .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
                .shadow(radius: 3, x: 0 ,y: 4)
            VStack(alignment: .leading, spacing: 10) {
                
                Text("RUN NEWS")
                    .font(.system(size: 20))
                    .fontWeight(.heavy)
                    .padding(.leading, 30)
                Text("이달의 교통 뉴스를 확인해보고\n우리가 알릴 수 있는 방법을 생각해봐요.")
                    .font(.system(size: 12))
                    .fontWeight(.regular)
                    .foregroundColor(.secondary)
                    .padding(.leading, 30)
                Divider()
                
                TabView {
                    YouTubeView(videoId: "HyVuk9hksRc")
                        .frame(width: 1980 / 6, height: 1080 / 6)
                        .cornerRadius(10)
                    YouTubeView(videoId: "TU-O2e1ll10")
                        .frame(width: 1980 / 6, height: 1080 / 6)
                        .cornerRadius(10)
                    YouTubeView(videoId: "wIX_f4YDTwk")
                        .frame(width: 1980 / 6, height: 1080 / 6)
                        .cornerRadius(10)
                }
                .tabViewStyle(PageTabViewStyle())
                .frame(height: 1080 / 6 + 80)
                .frame(maxWidth: .infinity)
                .background(.black)
                .cornerRadius(10)
                .padding(.horizontal)
                
                Group {
                    HStack {
                        Spacer()
                        Text("이달의 불편한 장소")
                        Spacer()
                    }
                    .padding(.bottom, 13)
                    .padding(.top)
                    HStack(alignment: .top) {
                        Spacer()
                        VStack {
                            Circle().frame(width: 41, height: 41)
                                .foregroundColor(.black)
                        }
                        Divider().frame(height: 41)
                        VStack {
                            Circle().frame(width: 41, height: 41)
                                .foregroundColor(.black)
                        }
                        Divider().frame(height: 41)
                        VStack {
                            Circle().frame(width: 41, height: 41)
                                .foregroundColor(.black)
                        }
                        Spacer()
                    }
                    Divider()
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 45)
            
            
            Text("도움을 주러 가볼까요?")
                .foregroundColor(.gray)
                .padding(.top)
            Spacer()
            Button {
                gotoRun = true
            } label: {
                Text("START")
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(.black)
                    .font(.custom("SF Pro Text", size: 20))
                    .foregroundColor(.sesacMint)
                    .cornerRadius(10)
            }
            .padding(.top   )
            .padding(.horizontal)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $gotoRun) {
            MainRunView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView()
        }
    }
}
