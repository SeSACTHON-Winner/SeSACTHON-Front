//
//  SecondView.swift
//  SeSACTHON_Watch Watch App
//
//  Created by ChoiYujin on 2023/06/04.
//

import SwiftUI

struct RunningView: View {
    
    @State var isNext = false
    @State var isEnd = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: -10) {
            Spacer()
            Text("1.2KM")
                .padding(.top, 30)
                .padding(.leading, 10)
            RunningTimeView()
            HStack(alignment: .bottom, spacing: 10) {
                Button {
                    isNext = true
                } label: {
                    watchReportBtn()
                }
                .buttonStyle(PlainButtonStyle())
                Button {
                    isEnd = true
                } label: {
                    watchRunningBtn(color: .white, btnText: "STOP")
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.leading, 10)
            }
            .padding(.vertical, 20)
            .padding(.leading, 10)
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity)
        .navigationDestination(isPresented: $isNext) {
            ReportView()
        }
        .navigationDestination(isPresented: $isEnd) {
            RunningEndView()
        }
    }
}

extension RunningView {
    func watchRunningBtn(color: Color, btnText: String) -> some View {
        return Circle()
            .foregroundColor(Color.init(hex: "D9D9D9").opacity(0.2))
            .overlay {
                Circle().stroke(lineWidth: 3).foregroundColor(color)
                Text(btnText)
                    .font(.custom("SF Pro Text", size: 12))
                    .foregroundColor(color)
                    .italic()
            }
            .frame(width: 42, height: 42)
    }
    func watchReportBtn() -> some View {
        Circle()
            .foregroundColor(Color.init(hex: "D9D9D9").opacity(0.2))
            .overlay {
                Circle().stroke(lineWidth: 3).foregroundColor(.sesacMint)
                Image("icon _bell outline_")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.sesacMint)
                    .frame(width: 35)
            }
            .frame(width: 56, height: 56)
    }
}

struct RunningView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RunningView()
        }
        .tint(.sesacMint)
    }
}
