//
//  ReportSubmitView.swift
//  SeSACTHON_App
//
//  Created by Lee Jinhee on 2023/06/02.
//

import SwiftUI

struct ReportSubmitView: View {
    
    @Binding var selection: MainRunHomeView.Status
    @Binding var pickedImage: Image?
    @Binding var isSendNotConfirmed: Bool
    //@Binding var helpCount: Int
    @ObservedObject var runStateManager = RunStateManager.shared
    @ObservedObject var wsManager = WatchSessionManager.sharedManager
    
    var body: some View {
        VStack(spacing: 40) {
            
            VStack(spacing: 20) {
                
                Image("icon_\(returnEngRawvalue(type: selection))_main")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .padding(.vertical,20)
                
                
                Text("\(selection.rawValue)")
                Text("\(wsManager.watchRunDAO.helpNum)") //TODO: Data 연결
                    .font(.system(size: 128, weight: .heavy))
                    .foregroundColor(Color("MainColor"))
                    .italic()
                    .frame(height: 120)
                    
                Text("도움 감사드립니다.")
                    .padding(.vertical, 20)
                    .padding(.bottom, 20)
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
                Image("GORUN")
            }
            .padding(.bottom, 94)
        }
        .onAppear {
            print("returnEngRawvalue(type: selection): \(returnEngRawvalue(type: selection))")
        }
    }
}
//
//struct ReportSubmitView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            ReportSubmitView(selection: .constant(.gradient), pickedImage: .constant(Image(systemName: "bolt")), isSendNotConfirmed: .constant(false), helpCount: .constant(9))
//        }
//    }
//}

extension ReportSubmitView {
    func returnEngRawvalue(type: MainRunHomeView.Status) -> String {
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
