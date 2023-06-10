//
//  ReportSubmitView.swift
//  SeSACTHON_App
//
//  Created by Lee Jinhee on 2023/06/02.
//

import SwiftUI

struct ReportSubmitView: View {
    @Binding var selection: Status
    var body: some View {
        VStack(spacing: 40) {
            Spacer().frame(height: 134)
            VStack {
                Spacer()
                Text("\(selection.rawValue)")
                Text("1") //TODO: Data 연결
                    .font(.system(size: 128, weight: .black))
                    .foregroundColor(Color("MainColor"))
                    .italic()
                Text("첫번째 보고 감사합니다")
                Spacer()
                NavigationLink {
                    //TODO: 커스텀 카메라 뷰로 이동 pop으로 수정
                    MainRunView()
                } label: {
                    Text("새로운 보고하기")
                        .font(.system(size: 12, weight: .medium))

                }
                .frame(width: 144, height: 32)
                .foregroundColor(.black)
                .background(.white)
                .cornerRadius(16)
                
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
                    .foregroundColor(Color("MainColor"))
                    .italic()
                    .frame(width: 120, height: 120)
                    .background(.black)
                    .cornerRadius(60)
            }
            .padding(.bottom, 94)
        }.edgesIgnoringSafeArea(.all)
    }
}

struct ReportSubmitView_Previews: PreviewProvider {
    static var previews: some View {
        ReportSubmitView(selection: .constant(.gradient))
    }
}
