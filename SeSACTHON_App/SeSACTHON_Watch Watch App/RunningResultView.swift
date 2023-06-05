//
//  RunningResultView.swift
//  SeSACTHON_Watch Watch App
//
//  Created by ChoiYujin on 2023/06/05.
//

import SwiftUI

struct RunningResultView: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                VStack(alignment: .leading, spacing: -10) {
                    Text("05 : 12")
                        .font(.custom("SF Pro Text", size: 38))
                        .tracking(-1)
                    Text(": 58")
                        .font(.custom("SF Pro Text", size: 25))
                        .tracking(-1)
                }
                .padding(.bottom)
                .foregroundStyle(
                    LinearGradient(
                        colors: [.sesacMint, .sesacLightGreen],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .foregroundColor(.sesacMint)
                .italic()
                Spacer()
            }
            .frame(maxWidth: .infinity)
            // MARK: - RunningResult
            Text("결과가 들어갈 자리")
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

struct RunningResultView_Previews: PreviewProvider {
    static var previews: some View {
        RunningResultView()
    }
}
