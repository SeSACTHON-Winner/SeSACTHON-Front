//
//  ProfileView.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/06.
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State var nickname = ""
    
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
                Text("PROFILE")
                    .font(.custom("SF Pro Text", size: 32))
                    .foregroundColor(.white)
                    .italic()
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom)
            .padding(.horizontal)
            .background(.black)
            Color.black.frame(height: 20)
                .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
                .shadow(radius: 3, x: 0 ,y: 4)
            HStack(spacing: 29) {
                Image("Camera")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 126)
                    .padding(.leading, 59)
                VStack {
                    HStack {
                        TextField("닉네임", text: $nickname)
                            .frame(width: 100)
                            .font(.system(size: 24))
                            .fontWeight(.bold)
                        Image(systemName: "highlighter")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    HStack {
                        Text("총 도움")
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                        Image(systemName: "1.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 21)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.top, 69)
            .padding(.bottom, 60)
            
            HStack {
                Text("최근 활동")
                Spacer()
            }
            .padding(.leading, 30)
            .padding(.vertical)
            
            ScrollView {
                RunRecentView()
                RunRecentView()
                RunRecentView()
                RunRecentView()
            }
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

extension ProfileView {
    
    private func customListItem(profileImage: Image) -> some View {
        
        return ZStack {
            Color.init(hex: "f5f5f5")
                .frame(height: 160)
                .cornerRadius(14)
                .padding(.top, 20)
                .padding(.horizontal, 10)
                .shadow(radius: 3, x: 2, y: 2)
            
            VStack {
                HStack {
                    Color.black
                        .frame(width: 63,height: 63)
                        .cornerRadius(10)
                    VStack(alignment: .leading, spacing: 11) {
                        Text("2023.06.17")
                            .font(.system(size: 24))
                            .fontWeight(.bold)
                        Text("수요일 효자시장 코스")
                            .font(.system(size: 14))
                            .fontWeight(.medium)
                    }
                    .padding(.leading, 27)
                    Spacer()
                }
                .padding(.leading, 27)
                .padding(.top, 27)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("1.09")
                            .font(.system(size: 24))
                            .fontWeight(.bold)
                        Text("Km")
                    }
                    VStack(alignment: .leading) {
                        Text("8'24'")
                            .font(.system(size: 24))
                            .fontWeight(.bold)
                        Text("Pace")
                    }
                    .padding(.leading, 40)
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("09:13")
                            .font(.system(size: 24))
                            .fontWeight(.bold)
                        Text("Time")
                    }
                    .padding(.leading, 10)
                    Spacer()
                    VStack(alignment: .leading) {
                        Image(systemName: "1.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 21)
                        Text("Help")
                    }
                }
                
                .padding(.horizontal, 26)
            }
        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProfileView()
        }
    }
}
