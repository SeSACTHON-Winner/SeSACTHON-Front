//
//  RunEndView.swift
//  SeSACTHON_App
//
//  Created by Lee Jinhee on 2023/06/03.
//

import SwiftUI

struct RunEndView: View {
    @Binding var swpSelection: Int
    @State var courseName: String = "효자공원 철길 코스"
    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment: .leading){
                    Spacer().frame(height: 60)
                    TopProfileView(title: "FINISH")
                        .foregroundColor(.blue)
                    Spacer()
                    Text("2023년 2월 5일")
                        .font(.system(size: 16, weight: .medium))
                        .multilineTextAlignment(.center)
                    HStack {
                        VStack(alignment: .leading, spacing: 20) {
                            Text("15.1km")
                                .font(.system(size: 64, weight: .black)).italic()
                                .frame(alignment: .leading)
                                .foregroundColor(Color("MainColor"))
                            Spacer().frame(height: 20)
                            HStack(spacing: 20) {
                                Text("시간")
                                    .font(.system(size: 12, weight: .medium))
                                    .frame(width: 60, alignment: .leading)
                                Text("14:13:22")
                                    .font(.system(size: 24, weight: .bold)).italic()
                            }
                            HStack(spacing: 20) {
                                Text("소모 칼로리")
                                    .font(.system(size: 12, weight: .medium))                 .multilineTextAlignment(.leading)
                                    .frame(width: 60, alignment: .leading)
                                Text("321 kcal")
                                    .font(.system(size: 24, weight: .bold)).italic()
                            }
                            HStack(spacing: 20) {
                                Text("평균 페이스")
                                    .font(.system(size: 12, weight: .medium))                           .frame(width: 60, alignment: .leading)
                                
                                Text("6’12”")
                                    .font(.system(size: 24, weight: .bold)).italic()
                            }
                            HStack(spacing: 20) {
                                Text("도움 개수")
                                    .font(.system(size: 12, weight: .medium))                           .frame(width: 60, alignment: .leading)
                                
                                Text("2")
                                    .font(.system(size: 24, weight: .bold)).italic()
                            }
                            HStack(spacing: 20) {
                                Text("총 도움")
                                    .font(.system(size: 12, weight: .medium))                           .frame(width: 60, alignment: .leading)
                                
                                Text("13")
                                    .font(.system(size: 24, weight: .bold)).italic()
                                    .foregroundColor(Color("MainColor"))
                                
                            }
                            
                        }
                        Spacer()
                    }
                    Spacer()
                    TextField("hi", text: $courseName)
                    
                        .textFieldStyle(.roundedBorder)
                        .cornerRadius(10)
                        .foregroundColor(.black)
                        .padding(.bottom, 26)
                }
                .padding(.horizontal, 28)
                .foregroundColor(.white)
                .frame(maxHeight: 568)
                .background(Color.black)
                .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
                .shadow(color: .black.opacity(0.25),radius: 4, x: 0, y: 4)
                Spacer()
                VStack (alignment: .leading){
                    Text("최근 활동")
                        .font(.system(size: 16, weight: .heavy))
                        .padding(.leading, 24)
                        .padding(.vertical, 12)
                    RunRecentView()
                    
                    RunRecentView()
                }
                
            }
            
        }.edgesIgnoringSafeArea(.all)
    }
}

struct RunRecentView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 12) {
                Image(systemName: "map").resizable().frame(width: 50, height: 50).background(.black).cornerRadius(5)
                VStack(alignment: .leading, spacing: 8){
                    Text("2023.03.12")
                        .font(.system(size: 12, weight: .medium)).opacity(0.3)
                    Text("효자시장 우동전용 산책길")
                        .font(.system(size: 14, weight: .medium)).opacity(0.5)
                }
                Spacer()
                
            }
            HStack(spacing: 26.0) {
                VStack(alignment: .leading, spacing: 14) {
                    Text("1.24")
                        .font(.system(size: 18, weight: .semibold)).italic()
                    Text("Km")
                        .font(.system(size: 12, weight: .regular))
                }
                VStack(alignment: .leading, spacing: 14) {
                    Text("15:07")
                        .font(.system(size: 18, weight: .semibold)).italic()
                    Text("Time")
                        .font(.system(size: 12, weight: .regular))
                }
                VStack(alignment: .leading, spacing: 14) {
                    Text("203")
                        .font(.system(size: 18, weight: .semibold)).italic()
                    Text("Kcal")
                        .font(.system(size: 12, weight: .regular))
                }
                VStack(alignment: .leading, spacing: 14) {
                    Text("2")
                        .font(.system(size: 18, weight: .semibold)).italic()
                    Text("도움")
                        .font(.system(size: 12, weight: .regular))
                }
            }
        }
        .padding(20)
        .background(Color("ListBackgroundColor"))
        .cornerRadius(14)
        .padding(.horizontal, 24)
        .frame(height: 148)
        .frame(maxWidth: .infinity)
        .shadow(radius: 4, x: 2, y: 2)
        .padding(.bottom, 20)
    }
}

struct RunEndView_Previews: PreviewProvider {
    static var previews: some View {
        RunEndView(swpSelection: .constant(2))
    }
}
