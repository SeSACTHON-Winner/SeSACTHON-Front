//
//  SpeechBubble.swift
//  SeSACTHON_App
//
//  Created by musung on 2023/06/12.
//

import SwiftUI

struct SpeechBubble: View {
    var body: some View {
        VStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.black)
        }
    }
}

struct SpeechBubble_Previews: PreviewProvider {
    static var previews: some View {
        SpeechBubble()
    }
}
