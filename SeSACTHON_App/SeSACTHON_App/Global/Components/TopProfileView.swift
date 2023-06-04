//
//  TopProfileView.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/04.
//

import SwiftUI

struct TopProfileView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16)
                    .foregroundColor(.white)
                    .padding(.trailing, 26)
            }
            Spacer()
            Text("Map")
                .font(.custom("SF Pro Text", size: 40))
                .foregroundColor(.white)
                .italic()
            Spacer()
            Image("Camera")
                .resizable()
                .frame(width: 40, height: 40)
                .padding(.leading)
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
