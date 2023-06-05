//
//  SecondView.swift
//  SeSACTHON_Watch Watch App
//
//  Created by ChoiYujin on 2023/06/04.
//

import SwiftUI

struct RunningView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State var isNext = false
    @State var isEnd = false
    @State var isRunning = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: -10) {
            Spacer()
            Text("1.2KM")
                .padding(.top, 30)
                .padding(.leading, 10)
            RunningTimeView()
            HStack(alignment: .top, spacing: 10) {
                Button {
                    isNext = true
                } label: {
                    watchReportBtn()
                }
                .buttonStyle(PlainButtonStyle())
                Button {
                    isRunning.toggle()
                    if !isRunning {
                        isEnd = true
                    }
                    
                    
                } label: {
                    watchRunningBtn(color: .white, systemName: isRunning ? "pause.fill" : "play.fill")
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.leading, 10)
                Button {
                    // MARK: - restart logic
                    
                } label: {
                    watchRunningBtn(color: .white, systemName: "repeat")
                }
                .buttonStyle(PlainButtonStyle())
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
        .navigationBarBackButtonHidden(true)
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

extension RunningView {
    func watchRunningBtn(color: Color, systemName: String) -> some View {
        return Circle()
            .foregroundColor(Color.init(hex: "D9D9D9").opacity(0.2))
            .overlay {
                Circle().stroke(lineWidth: 2).foregroundColor(color)
                Image(systemName: systemName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 11)
                    .foregroundColor(.white)
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