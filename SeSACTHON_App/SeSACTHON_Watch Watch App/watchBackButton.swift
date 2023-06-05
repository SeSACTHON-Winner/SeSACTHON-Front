//
//  watchBackButton.swift
//  SeSACTHON_Watch Watch App
//
//  Created by ChoiYujin on 2023/06/05.
//

import SwiftUI

struct watchBackButton: View {
    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: "chevron.backward.circle.fill")
                .foregroundColor(.sesacMint)
                .frame(width: 20, height: 20)
            Text("RUN")
                .foregroundColor(.sesacMint)
                .fontWeight(.medium)
        }
    }
}

struct watchBackButton_Previews: PreviewProvider {
    static var previews: some View {
        watchBackButton()
    }
}
