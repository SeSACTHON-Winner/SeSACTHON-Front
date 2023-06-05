//
//  ReportView.swift
//  SeSACTHON_Watch Watch App
//
//  Created by ChoiYujin on 2023/06/04.
//

import SwiftUI

struct ReportView: View {
    
    @State var isNext = false
    
    
    var body: some View {
        VStack {
            RunningTimeView()
            
            List {
                Group {
                    Button {
                        isNext = true
                    } label: {
                        listButton(btnText: "경사도", systemName: "cart")
                    }
                    Button {
                        isNext = true
                    } label: {
                        listButton(btnText: "좁은 길", systemName: "cart")
                    }
                    Button {
                        isNext = true
                    } label: {
                        listButton(btnText: "자연재해", systemName: "cart")
                    }
                    Button {
                        isNext = true
                    } label: {
                        listButton(btnText: "공사 중", systemName: "cart")
                    }
                }
                .frame(height: 90)
                .foregroundColor(.sesacMint)
                .font(.system(size: 14))
                .navigationDestination(isPresented: $isNext) {
                    EmptyView()
                }
            }
            .listStyle(CarouselListStyle())
            .font(.custom("SF Pro Text", size: 24))
            .foregroundColor(.white)
            Spacer()
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity)
        
        
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

