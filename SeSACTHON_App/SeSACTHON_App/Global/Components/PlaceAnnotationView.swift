//
//  PlaceAnnotationView.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/04.
//

import SwiftUI

struct PlaceAnnotationView: View {
    
    @State var dangerPlace: DangerInfoMO
    
    var body: some View {
        VStack(spacing: 0) {
            
            Color.white.frame(width: 100, height: 60)
                .cornerRadius(10)
                .overlay {
                    
                    switch dangerPlace.type {
                    case .slope:
                        Text("🎢")
                    case .construction:
                        Text("🚧")
                    case .step:
                        Image(systemName: "figure.stair.stepper")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 32)
                    case .narrow:
                        Text("⛔")
                    }
                }
                .shadow(radius: 3)
            Image(systemName: "arrowtriangle.down.fill")
                .font(.caption)
                .scaleEffect(2)
                .foregroundColor(.white)
                .shadow(radius: 2, x: 0, y: 4)
        }
    }
}

//struct PlaceAnnotationView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaceAnnotationView()
//    }
//}
