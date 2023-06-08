//
//  Blur.swift
//  Running
//
//  Created by Ah lucie nous gênes 🍄 on 11/02/2023.
//


import SwiftUI


struct Blur: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) { }
}
