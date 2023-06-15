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
    @ObservedObject var wsManager = WatchSessionManager.sharedManager
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            Spacer()
            Text("05 : 12")
                .font(.custom("SF Pro Text", size: 52))
                .tracking(-2)
                .foregroundStyle(
                    LinearGradient(
                        colors: [.sesacMint, .sesacLightGreen],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            
            
            .foregroundColor(.sesacMint)
            .italic()
            Spacer()
            // MARK: - info
            runningInfoView()
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        //MARK: 혹시 모르니 체크!
//        .navigationDestination(isPresented: $isRunningEnd) {
//            StartView()
//        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    dismiss()
                } label: {
                    watchBackButton()
                }
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
            .frame(width: 60, height: 60)
            .padding(.leading, 18)
    }
    
    @ViewBuilder
    func runningInfoView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Group {
                //라딘 수정
                Text("\(Measurement(value: wsManager.watchRunDAO.distance, unit: UnitLength.meters).formatted())")
                Text("\(wsManager.watchRunDAO.helpNum)")
            }
            .tracking(-0.8)
            .font(.custom("SF Pro Text", size: 14))
            .padding(.leading, 20)
            HStack {
                Button {
                    //MARK: 혹시모르니 체크! 스탑 버튼
                    //isRunningEnd = true
                    wsManager.sendStop()
                    dismiss()
                } label: {
                    watchCircleSytemImageBtn(color: .sesacMint, systemName: "checkmark")
                }
                .buttonStyle(PlainButtonStyle())
                Spacer()
                Button {
                    dismiss()
                    wsManager.sendStart()
                } label: {
                    watchCircleSytemImageBtn(color: .white, systemName: "xmark")
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.trailing, 16)
            }
            .padding(.top, 13)
        }
    }
}



struct RunningEndView_Previews: PreviewProvider {
    static var previews: some View {
        RunningEndView()
    }
}
