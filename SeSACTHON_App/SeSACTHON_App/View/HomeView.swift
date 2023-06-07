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
            ZStack {
                TabView {
                    newsView(title: "이달에 대중교통\n임산부석 확대", content: "이달의 교통 뉴스를 확인해보고\n우리가 알릴수 있는 방법을 생각해봐요.", image: Image("Rectangle 136"))
                    newsView(title: "이달에 대중교통\n임산부석 확대", content: "이달의 교통 뉴스를 확인해보고\n우리가 알릴수 있는 방법을 생각해봐요.", image: Image("Rectangle 136"))
                    newsView(title: "이달에 대중교통\n임산부석 확대", content: "이달의 교통 뉴스를 확인해보고\n우리가 알릴수 있는 방법을 생각해봐요.", image: Image("Rectangle 136"))
                    newsView(title: "이달에 대중교통\n임산부석 확대", content: "이달의 교통 뉴스를 확인해보고\n우리가 알릴수 있는 방법을 생각해봐요.", image: Image("Rectangle 136"))
                }
                .tabViewStyle(PageTabViewStyle())
            }
            .background(.black)
            
            Text("도움을 주러 가볼까요?")
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .padding(.vertical)
                .padding(.top, 24)
                .background(.black)
            Button {
                gotoRun = true
            } label: {
                Text("START RUNNING")
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(.black)
                    .font(.custom("SF Pro Text", size: 24))
                    .foregroundColor(.sesacMint)
            }
        }
        .frame(maxWidth: .infinity)
        .edgesIgnoringSafeArea([.top, .horizontal])
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $gotoRun) {
            MainRunView()
        }
    }
}

extension HomeView {
    
    func newsView(title: String, content: String, image: Image) -> some View {
            return ZStack {
                Color.clear.overlay {
                    image
                        .resizable()
                        .scaledToFill()
                }
                VStack(alignment: .leading, spacing: 0) {
                    Spacer()
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("RUN NEWS")
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                                .foregroundColor(.sesacMint)
                            Text(title)
                                .font(.system(size: 24))
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                            Text(content)
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }
                }
                .padding(.bottom, 78)
                .padding(.leading, 18)
                .frame(maxWidth: .infinity)
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
