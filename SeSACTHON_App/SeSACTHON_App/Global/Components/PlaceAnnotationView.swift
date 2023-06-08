//
//  PlaceAnnotationView.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/04.
//

import SwiftUI

struct PlaceAnnotationView: View {
    
    
    let type: DangerInfoMO.DangerType
    
    var body: some View {
        VStack(spacing: 0) {
            
            Color.white.frame(width: 100, height: 60)
                .cornerRadius(10)
                .overlay {
                    HStack {
                        switch type {
                        case .slope:
                            Text("🎢")
                        case .step:
                            Image(systemName: "figure.stair.stepper")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 32)
                        case .construction:
                            Text("🚧")
                        case .narrow:
                            Text("⛔")
                        }
                    }
                }
                .shadow(radius: 3)
            Image(systemName: "arrowtriangle.down.fill")
                .font(.caption)
                .scaleEffect(2)
                .foregroundColor(.white)
//                .offset(x: 0, y: -5)
                .shadow(radius: 2, x: 0, y: 4)
        }
    }
}

//struct PlaceAnnotationView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaceAnnotationView()
//    }
//}
