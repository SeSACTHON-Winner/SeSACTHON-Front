//
//  RunningTimeView.swift
//  SeSACTHON_Watch Watch App
//
//  Created by ChoiYujin on 2023/06/04.
//

import SwiftUI

struct RunningTimeView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("05:12")
                    .font(.custom("SF Pro Text", size: 30))
                Text(": 58")
                    .font(.custom("SF Pro Text", size: 20))
            }
            .foregroundColor(.sesacMint)
            .italic()
            HStack {
                
            }
            Spacer()
        }
        .padding(.leading, 20)
    }
}

struct RunningTimeView_Previews: PreviewProvider {
    static var previews: some View {
        RunningTimeView()
    }
}
