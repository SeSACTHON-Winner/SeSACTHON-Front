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
    @State var isViewMore = false
    
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
                    newsView(title: "단차의 높이, 차별의 높이", content: "차도와 보도를 구분하기 위하여 차도에 연석을 설치하는 경우에는 그 높이를 25cm 이하로 해야합니다.이는 외국 도시들(10-15cm)에 비해 높습니다.", image: Image("NewsSample1"))
                    newsView(title: "교통약자들이 불편해 하는 최소 경사도 8.3%", content: "교통약자의 이동편의 증진법 시행규칙 <별표1>에서 교통약자가 통행할 수 있는 보도의 기울기는 최대 8.3%이하로 하게끔 하고 있습니다.", image: Image("NewsSample2"))
                    newsView(title: "보도블럭 균열에 넘어지는 교통약자들", content: "교통약자들이 보도블럭의 균열에는 다양한 어려움을 느낄 수 있습니다. 예를 들어, 보행 장애가 있는 사람들은 균열로 인해 휠체어나 보행 보조기구를 움직이는 데에 어려움을 겪을 수 있습니다.", image: Image("NewsSample3"))
                    newsView(title: "보도의 최소폭은 얼마일까?", content: "보도의 유효폭은 보행자의 통행량과 주변 토지 이용 상황을 고려하여 결정하되, 최소 2미터 이상으로 하여야 합니다.", image: Image("NewsSample4"))
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
            LinearGradient(
                colors: [.clear, .black],
                startPoint: .top,
                endPoint: .bottom
            )
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
//                        Text("RUN NEWS")
//                            .font(.system(size: 18))
//                            .fontWeight(.bold)
//                            .foregroundColor(.sesacMint)
                        Text(title)
                            .font(.system(size: 26))
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .tracking(1)
                        Text(content)
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .lineSpacing(10)
                    }
                    Spacer()
                }
            }
            .padding(.bottom, 78)
            .padding(.horizontal, 18)
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
