//
//  TopProfileView.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/04.
//

import SwiftUI

struct TopProfileView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button {
                    //
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.white)
                }
                Image("Camera")
                    .resizable()
                    .frame(width: 34, height: 34)
                    .padding(.leading)
                Spacer()
            }
            
            .padding()
            Text("Map")
                .font(.custom("SF Pro Text", size: 24))
                .foregroundColor(.white)
                .italic()
                .padding(.leading, 58)
                .padding(.bottom)
        }
        .background(.black)
    }
}

struct TopProfileView_Previews: PreviewProvider {
    static var previews: some View {
        TopProfileView()
    }
}
