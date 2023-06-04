//
//  RunningEndView.swift
//  SeSACTHON_Watch Watch App
//
//  Created by ChoiYujin on 2023/06/04.
//

import SwiftUI

struct RunningEndView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State var isRunningEnd = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("05:12")
                            .font(.custom("SF Pro Text", size: 30))
                        Text(": 58")
                            .font(.custom("SF Pro Text", size: 20))
                    }
                    .foregroundColor(.sesacMint)
                    .italic()
                    Spacer()
                }
                .padding(.leading, 20)
                
                // MARK: - info
                if isRunningEnd {
                    runningResultView()
                } else {
                    runningInfoView()
                }
                Spacer()
            }
        }
    }
}

extension RunningEndView {
    func watchCircleSytemImageBtn(color: Color, systemName: String) -> some View {
        Circle()
            .foregroundColor(Color.init(hex: "D9D9D9").opacity(0.2))
            .overlay {
                Circle().stroke(lineWidth: 2).foregroundColor(color)
                Image(systemName: systemName)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(color)
                    .frame(width: 20)
            }
            .frame(width: 70, height: 70)
            .padding(.leading, 18)
    }
    
    @ViewBuilder
    func runningInfoView() -> some View {
        Group {
            Text("2 km")
            Text("도움 2개")
        }
        .font(.custom("SF Pro Text", size: 16))
        .padding(.leading, 20)
        
        HStack {
            Button {
                isRunningEnd = true
            } label: {
                watchCircleSytemImageBtn(color: .sesacMint, systemName: "checkmark")
            }
            .buttonStyle(PlainButtonStyle())
            Button {
                dismiss()
            } label: {
                watchCircleSytemImageBtn(color: .white, systemName: "xmark")
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.top, 20)
        Spacer()
    }
    
    
    @ViewBuilder
    func runningResultView() -> some View {
        Text("러닝 결과로 바꿀 뷰입니다.")
    }
}



struct RunningEndView_Previews: PreviewProvider {
    static var previews: some View {
        RunningEndView()
    }
}
