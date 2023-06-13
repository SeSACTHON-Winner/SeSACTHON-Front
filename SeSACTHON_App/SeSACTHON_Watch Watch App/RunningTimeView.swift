//
//  RunningTimeView.swift
//  SeSACTHON_Watch Watch App
//
//  Created by ChoiYujin on 2023/06/04.
//

import SwiftUI

struct RunningTimeView: View {
    @ObservedObject var wsManager = WatchSessionManager.sharedManager
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: -10) {
                Text("\(formattedTime(wsManager.watchRunDAO.duration))")
                    .tracking(-2)
                    .font(.custom("SF Pro Text", size: 54))
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(.sesacMint)
            .italic()
            Spacer()
        }
        .frame(maxWidth: .infinity)
        
        
    }
}
private func formattedTime(_ time: TimeInterval) -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.minute, .second]
    formatter.unitsStyle = .positional
    formatter.zeroFormattingBehavior = .pad
    //timeString = formatter.string(from: time) ?? ""
    return formatter.string(from: time) ?? ""
}
struct RunningTimeView_Previews: PreviewProvider {
    static var previews: some View {
        RunningTimeView()
    }
}
