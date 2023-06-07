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
                        Image(systemName: "pencil")
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
            .padding(.bottom, 93)
            
            ScrollView {
               customListItem(profileImage: Image(""))
               customListItem(profileImage: Image(""))
               customListItem(profileImage: Image(""))
               customListItem(profileImage: Image(""))
            }
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

extension ProfileView {
    
    private func customListItem(profileImage: Image) -> some View {
        Color.init(hex: "D9D9D9")
            .frame(height: 160)
            .cornerRadius(10)
            .padding(.top, 20)
            .overlay {
                VStack {
                    HStack {
                        Color.black
                            .frame(width: 63,height: 63)
                            .cornerRadius(10)
                            .padding(.leading, 26)
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
                    .padding(.top, 27)
                    HStack(spacing: 40) {
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
                        VStack(alignment: .leading) {
                            Text("09:13")
                                .font(.system(size: 24))
                                .fontWeight(.bold)
                            Text("Time")
                        }
                        VStack(alignment: .leading) {
                            Image(systemName: "1.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 21)
                            Text("Help")
                        }
                    }
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
