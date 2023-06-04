//
//  PlaceAnnotationView.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/04.
//

import SwiftUI

struct PlaceAnnotationView: View {
    var body: some View {
        VStack(spacing: 0) {
            
            Color.white.frame(width: 100, height: 60)
                .cornerRadius(10)
                .overlay {
                    HStack {
                        Text("😅")
                        Text("😂")
                    }
                }
            Image(systemName: "arrowtriangle.down.fill")
                .font(.caption)
                .scaleEffect(2)
                .foregroundColor(.white)
                .offset(x: 0, y: -5)
        }
    }
}

struct PlaceAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceAnnotationView()
    }
}
