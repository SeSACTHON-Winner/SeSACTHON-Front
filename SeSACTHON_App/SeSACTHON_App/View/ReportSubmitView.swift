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
            Spacer()
            VStack {
                Spacer()
                Text("3") //TODO: Data 연결
                    .font(.system(size: 128, weight: .black))
                    .foregroundColor(.teal)
                    .italic()
                Text("무성씨는 최고의 알리미")
                Spacer()
                NavigationLink {
                    //TODO: 맵(홈)으로 돌아가기 pop으로 수정
                    //TODO: Camera deinit
                    MainRunView()
                } label: {
                    Text("계속하기")
                }
                .frame(width: 144, height: 32)
                .foregroundColor(.black)
                .background(.white)
                .cornerRadius(16)
                
                Text("모든 알리미 보기")
                    .font(.system(size: 10, weight: .black))
                Spacer()
            }
            .frame(minWidth: 260)
            .background(.black)
            .foregroundColor(.white)
            .cornerRadius(40)
                        
            Button {
                //TODO: 맵(홈)으로 돌아가기
            } label: {
                Text("X")
                    .frame(width: 96, height: 96)
                    .foregroundColor(.white)
                    .background(.black)
                    .cornerRadius(48)
            }
            .padding(.bottom, 100)
        }
    }
}

struct ReportSubmitView_Previews: PreviewProvider {
    static var previews: some View {
        ReportSubmitView()
    }
}
