//
//  ReportView.swift
//  SeSACTHON_Watch Watch App
//
//  Created by ChoiYujin on 2023/06/04.
//

import SwiftUI

struct ReportView: View {
    
    @State var isNext = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: -10) {
                Text("05 : 12")
                    .font(.custom("SF Pro Text", size: 54))
                    .tracking(-2.2)
                Text(": 58")
                    .font(.custom("SF Pro Text", size: 36))
                    .tracking(-2.2)
            }
            .frame(maxWidth: .infinity)
            .background()
            .backgroundStyle(
                LinearGradient(
                    colors: [.sesacMint, .sesacMint, .sesacLightGreen],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(4.8)
            .foregroundColor(.black)
            .italic()
            List {
                Group {
                    Button {
                        isNext = true
                    } label: {
                        HStack {
                            Text("🎢")
                                .font(.custom("SF Pro Text", size: 24))
                            Text("경사도")
                                .font(.custom("SF Pro Text", size: 14))
                        }
                           
                    }
                    Button {
                        isNext = true
                    } label: {
                        HStack {
                            Text("🌊")
                                .font(.custom("SF Pro Text", size: 24))
                            Text("자연재해")
                                .font(.custom("SF Pro Text", size: 14))
                        }
                    }
                    Button {
                        isNext = true
                    } label: {
                        HStack {
                            Text("⛔")
                                .font(.custom("SF Pro Text", size: 24))
                            Text("좁은길")
                                .font(.custom("SF Pro Text", size: 14))
                        }
                    }
                    Button {
                        isNext = true
                    } label: {
                        HStack {
                            Text("🚧")
                                .font(.custom("SF Pro Text", size: 24))
                            Text("공사중")
                                .font(.custom("SF Pro Text", size: 14))
                        }
                    }
                }
                .frame(height: 90)
                .frame(maxWidth: .infinity)
                .foregroundColor(.sesacMint)
                .navigationDestination(isPresented: $isNext) {
                    EmptyView()
                }

            }
            .listStyle(CarouselListStyle())
            
        }
        .frame(maxWidth: .infinity)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    dismiss()
                } label: {
                    watchBackButton()
                }
            }
        }
        
        
    }
}

extension ReportView {
    
    
    func listButton(btnText: String, systemName: String) -> some View {
        return HStack(spacing: 20) {
            
            Image(systemName: systemName)
                .resizable()
                .scaledToFit()
                .frame(width: 40)
                .padding(.leading)
            Text(btnText)
                .font(.system(.callout))
        }
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ReportView()
        }
    }
}

