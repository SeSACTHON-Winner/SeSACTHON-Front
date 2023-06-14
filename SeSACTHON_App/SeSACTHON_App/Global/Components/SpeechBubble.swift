//
//  SpeechBubble.swift
//  SeSACTHON_App
//
//  Created by musung on 2023/06/12.
//

import SwiftUI

struct SpeechBubble: View{
    var text: String
    var body: some View{
        HStack{
            Image("speechBubble")
                .resizable()
                .frame(width: 60.0, height: 60.0)
                .offset(y:45)
            ZStack{
                Image("talkBubble")
                    .resizable()
                    .frame(width: 297,height: 103)
                Text("안전한 보행로를 위해\n장애물을 신고해주세요.")
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .regular))
                    .offset(x: -20, y:-3)
            }
        }
    }
    
    struct Triangle: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.closeSubpath()
            
            return path
        }
    }
}

