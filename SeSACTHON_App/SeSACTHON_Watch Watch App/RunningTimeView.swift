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
            VStack(alignment: .leading, spacing: -10) {
                Text("05 : 12")
                    .tracking(-2)
                    .font(.custom("SF Pro Text", size: 54))
                Text(":58")
                    .font(.custom("SF Pro Text", size: 36))
                    .tracking(-2)
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(.sesacMint)
            .italic()
            Spacer()
        }
        .frame(maxWidth: .infinity)
        
        
    }
}

struct RunningTimeView_Previews: PreviewProvider {
    static var previews: some View {
        RunningTimeView()
    }
}
