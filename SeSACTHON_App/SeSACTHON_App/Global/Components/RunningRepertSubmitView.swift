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
    
    
    var body: some View {
                VStack(spacing: 30) {
                    
                    VStack(spacing: 20) {
                        
                        Image("\(returnEngRawvalue(type: selection))_white")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .padding(.vertical,20)
                            
                        Text("\(selection.rawValue)")
                        Text("1") //TODO: Data 연결
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
                    
                    Button {
                        isSendNotConfirmed = true
                        pickedImage = nil
                        Haptics.tap()
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
                }
            .edgesIgnoringSafeArea(.all)
            .padding(.top, 20)
    }
}

//struct RunningReportSubmitView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            ReportSubmitView(selection: .constant(.gradient), pickedImage: .constant(Image(systemName: "d")), isSendNotConfirmed: .constant(false))
//        }
//    }
//}

extension RunningReportSubmitView {
    func returnEngRawvalue(type: MainRunningView.Status) -> String {
        switch type {
        case .gradient:
            return "elevation"
        case .narrow:
            return "narrow"
        case .natural:
            return "construction"
        case .road:
            return "step"
        }
    }
}
