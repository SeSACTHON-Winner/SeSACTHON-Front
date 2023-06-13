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
    
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer().frame(height: 130)
            VStack {
                Spacer()
                
                Image("\(returnEngRawvalue(type: selection))_white")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
                Text("\(selection.rawValue)")
                Text("1") //TODO: Data 연결
                    .font(.system(size: 128, weight: .black))
                    .foregroundColor(Color("MainColor"))
                    .italic()
                Text("도움 감사드립니다.")
                    .padding(.vertical)
                Spacer()
            }
            .frame(minWidth: 274)
            .background(.black)
            .foregroundColor(.white)
            .cornerRadius(14)
            
            Button {
                isSendNotConfirmed = true
                
                pickedImage = nil
                
            } label: {
                Text("새로운 보고하기")
                    .font(.system(size: 12, weight: .medium))
            }
            .frame(width: 144, height: 32)
            .foregroundColor(.black)
            .background(.white)
            .cornerRadius(16)
            .shadow(radius: 4, x: 2, y: 2)
            
            Button {
                isSendNotConfirmed = true
                
                pickedImage = nil
                
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
        .ignoresSafeArea()
        .onAppear {
            print("returnEngRawvalue(type: selection): \(returnEngRawvalue(type: selection))")
            print("assets: \(returnEngRawvalue(type: selection))_white")
        }
    }
}

struct ReportSubmitView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ReportSubmitView(selection: .constant(.gradient), pickedImage: .constant(Image(systemName: "bolt")), isSendNotConfirmed: .constant(false))
        }
    }
}

extension ReportSubmitView {
    func returnEngRawvalue(type: MainRunHomeView.Status) -> String {
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
