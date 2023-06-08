//
//  RunListView.swift
//  Running
//
//  Created by Ah lucie nous gênes 🍄 on 26/02/2023.
//

import SwiftUI

struct RunListView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
            List {
                    RectangleView(distance: 5.7, duration: 32, speed: 10.5, elevation: 153)
                        .padding(.bottom, 10)
                    RectangleView(distance: 8.2, duration: 44, speed: 11.6, elevation: 208)
                        .padding(.bottom, 10)
                }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: backButton)
        }

        private var backButton: some View {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Retour")
                }
                .padding(.bottom, 30) 
            })
        }
    }

struct RectangleView: View {
    var distance: Double
    var duration: Int
    var speed: Double
    var elevation: Int
    
    var body: some View {
        VStack {
            HStack {
                Text(String(format: "%.1f km", distance))
                    .font(.title2).foregroundColor(.black)
                Spacer()
                Text("\(duration) min")
                    .font(.headline).foregroundColor(.black)
            }
            HStack {
                Text(String(format: "%.1f km/h", speed))
                    .font(.subheadline).foregroundColor(.black)
                Spacer()
                Text("\(elevation) m")
                    .font(.subheadline).foregroundColor(.black)
                Spacer()
                //Image(systemName: "heart.fill")
//                Text("\(heartRate) bpm").foregroundColor(.black)
//                    .font(.subheadline)
            }
        }
        .padding()
        .cornerRadius(10)
    }
}

struct RunListView_Previews: PreviewProvider {
    static var previews: some View {
        RunListView()
    }
}
