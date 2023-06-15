//
//  RunningRepertSubmitView.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/13.
//

import Foundation

import SwiftUI

struct RunningReportSubmitView: View {
    
    @Binding var selection: MainRunningView.Status
    @Binding var pickedImage: Image?
    @Binding var isSendNotConfirmed: Bool
    @Binding var helpCount: Int
    @ObservedObject var runStateManager = RunStateManager.shared
    
    
    var body: some View {
                VStack(spacing: 30) {
                    Spacer()
                    VStack(spacing: 20) {
                        
                        Image("icon_\(returnEngRawvalue(type: selection))_main")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .padding(.vertical,20)
                            
                        Text("\(selection.rawValue)")
                        Text("\(runStateManager.helpCount)") //TODO: Data 연결
                            .font(.system(size: 100, weight: .black))
                            .foregroundColor(Color("MainColor"))
                            .italic()
                            .frame(height: 90)
                        Text("도움 감사드립니다.")
                            .padding(.vertical, 20)
                            .padding(.bottom, 10)
                        
                    }
                    .frame(minWidth: 274)
                    .background(.black)
                    .foregroundColor(.white)
                    .cornerRadius(14)
                    .padding(.top, 50)
                    Spacer()
                    Button {
                        isSendNotConfirmed = true
                        pickedImage = nil
                        Haptics.tap()
                    } label: {
                        Image("GORUN")
                    }
                    .padding(.bottom, 94)
                }
            .edgesIgnoringSafeArea(.all)
            .padding(.top, 20)
    }
}

struct RunningReportSubmitView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ReportSubmitView(selection: .constant(.gradient), pickedImage: .constant(Image(systemName: "d")), isSendNotConfirmed: .constant(false), helpCount: .constant(3))
        }
    }
}

extension RunningReportSubmitView {
    func returnEngRawvalue(type: MainRunningView.Status) -> String {
        switch type {
        case .gradient:
            return "slope"
        case .narrow:
            return "narrow"
        case .natural:
            return "construction"
        case .road:
            return "step"
        }
    }
}
