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
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color("SpeechBubbleColor"))
                    .frame(width: 297,height: 103)
                Text(text).foregroundColor(.white)
                    .font(.system(size: 20, weight: .regular))
            }
            Triangle()
                .fill(Color("SpeechBubbleColor"))
                .frame(width:27,height:27)
                .offset(x:-105, y:-20)
            
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

