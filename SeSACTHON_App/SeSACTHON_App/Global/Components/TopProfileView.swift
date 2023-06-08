//
//  TopProfileView.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/04.
//

// MARK: - 디자인 계속 변경될 예정

import SwiftUI

struct TopProfileView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State var title = ""
    
    
    var body: some View {
        
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 10, height: 16)
                    .foregroundColor(.white)
                    .padding(.trailing, 10)
            }
            Text(title)
                .font(.custom("SF Pro Text", size: 32))
                .foregroundColor(.white)
                .italic()
            Spacer()
//            Button {
////                goProfile = true
//            } label: {
//                Image(systemName: "person.crop.circle.fill")
//                    .resizable()
//                    .frame(width: 34, height: 34)
//                    .padding(.leading)
//                    .foregroundColor(.white)
//            }
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 34, height: 34)
                .padding(.leading)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom)
        .background(.black)
    }
}

struct TopProfileView_Previews: PreviewProvider {
    static var previews: some View {
        TopProfileView()
    }
}
