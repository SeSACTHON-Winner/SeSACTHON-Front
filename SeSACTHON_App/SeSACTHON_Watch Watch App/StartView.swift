//
//  StartView.swift
//  SeSACTHON_Watch Watch App
//
//  Created by ChoiYujin on 2023/06/04.
//

import SwiftUI

struct StartView: View {
    @ObservedObject var wsManager = WatchSessionManager.sharedManager
    var body: some View {
//        //MARK: 워치에서 Start메세지 보내기
//        if wsManager.watchRunDAO.isStart && (wsManager.watchRunDAO.isStart || wsManager.watchRunDAO.isPause) {
//            RunningView().onChange(of: wsManager.watchRunDAO) { newValue in
//                print(newValue)
//            }
//        }
//        else{
            Button {
                wsManager.sendStart()
                //TODO: 라딘 - 아래 지워도 되는 지 확인하기
                wsManager.watchRunDAO.isStart = true
            } label: {
                StartButton()
            }
            .buttonStyle(PlainButtonStyle())
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $wsManager.watchRunDAO.isStart) {
                RunningView()
          //  }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            StartView()
        }
    }
}

struct StartButton: View {
    
    let textLeadingColor = Color.init(hex: "03FFF0")
    let textTrailingColor = Color.init(hex: "03D2FF")
    
    let outerCircle1Color = Color.init(hex: "5ADFD7")
    let outerCircle2Color = Color.init(hex: "A5C0BF")
    let outerCircle3Color = Color.init(hex: "2E2E2E")
    
    @State var animationAmount = 0.8
    
    var outerCircle: some View {
        ZStack {
            Circle()
                .foregroundColor(outerCircle3Color)
                .frame(width: 164, height: 164)
            Circle()
                .foregroundColor(outerCircle2Color)
                .frame(width: 154, height: 154)
            Circle()
                .foregroundColor(outerCircle1Color)
                .frame(width: 130, height: 130)
        }
    }
    
    var body: some View {
        ZStack {
            outerCircle
                .scaleEffect(animationAmount)
                .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true), value: animationAmount)
                .onAppear {
                    self.animationAmount = 1.1
                }
            Circle()
                .foregroundColor(.black)
                .frame(width: 120, height: 120)
                .shadow(radius: 4)
            Text("Start")
                .font(.custom("SF Pro Text", size: 32))
                .foregroundStyle(
                    LinearGradient(
                        colors: [textLeadingColor, textTrailingColor],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .italic()
        }
    }
}
