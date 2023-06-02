//
//  ReportSubmitView.swift
//  SeSACTHON_App
//
//  Created by Lee Jinhee on 2023/06/02.
//

import SwiftUI

struct ReportSubmitView: View {
    var body: some View {
        VStack(spacing: 40) {
            Spacer().frame(height: 134)
            VStack {
                Spacer()
                Text("3") //TODO: Data 연결
                    .font(.system(size: 128, weight: .black))
                    .foregroundColor(.teal)
                    .italic()
                Text("무성씨는 최고의 알리미")
                Spacer()
                NavigationLink {
                    //TODO: 커스텀 카메라 뷰로 이동 pop으로 수정
                    MainRunView()
                } label: {
                    Text("다른 사진찍기")
                }
                .frame(width: 144, height: 32)
                .foregroundColor(.black)
                .background(.white)
                .cornerRadius(16)
                
                Text("앨범 보기")
                    .font(.system(size: 10, weight: .black))
                Spacer()
            }
            .frame(minWidth: 274)
            .background(.black)
            .foregroundColor(.white)
            .cornerRadius(14)
            Spacer()
            NavigationLink {
                //TODO: Camera deinit
                //TODO: MainRun으로 돌아가기 pop 방식으로 수정
                MainRunView()
            } label: {
                Text("Go Run")
                    .font(.system(size: 30, weight: .black))
                    .foregroundColor(.teal)
                    .italic()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.white)
                    .background(.black)
                    .cornerRadius(60)
            }
            .padding(.bottom, 94)
        }.edgesIgnoringSafeArea(.all)
    }
}

struct ReportSubmitView_Previews: PreviewProvider {
    static var previews: some View {
        ReportSubmitView()
    }
}
