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
            VStack {
                RunningTimeView()
                HStack(spacing: 10) {
                    Button {
                        isEnd = true
                    } label: {
                        watchRunningBtn(color: .white, btnText: "STOP")
                    }
                    .buttonStyle(PlainButtonStyle())

                    
                    watchRunningBtn(color: .sesacMint, btnText: "GO")
                    Spacer()
                }
                .padding(.leading, 20)
                .padding(.bottom)
                HStack {
                    Button {
                        isNext = true
                    } label: {
                        watchReportBtn()
                    }
                    .buttonStyle(PlainButtonStyle())
                    Spacer()
                }
                .padding(.leading)
                Spacer()
            }
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
                Circle().stroke(lineWidth: 2).foregroundColor(color)
                Text(btnText)
                    .font(.custom("SF Pro Text", size: 12))
                    .foregroundColor(color)
                    .italic()
            }
            .frame(width: 40, height: 40)
    }
    func watchReportBtn() -> some View {
        Circle()
            .foregroundColor(Color.init(hex: "D9D9D9").opacity(0.2))
            .overlay {
                Circle().stroke(lineWidth: 2).foregroundColor(.sesacMint)
                Image(systemName: "bell")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.sesacMint)
                    .frame(width: 30)
                
            }
            .frame(width: 52, height: 52)
            .padding(.leading, 18)
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
