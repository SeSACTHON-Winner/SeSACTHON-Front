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
    
    enum dangerType {
        case slope
        case step
        case narrow
        case construct
        case none
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: -10) {
                Text("05 : 12")
                    .font(.custom("SF Pro Text", size: 32))
                    .tracking(-2.2)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 40)
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
                ReportButtonEmoji(emoji: "elevation_white", text: "경사도")
                ReportButtonEmoji(emoji: "step_white", text: "높은 턱")
                ReportButtonEmoji(emoji: "narrow_white", text: "좁은길")
                ReportButtonEmoji(emoji: "construction_white", text: "공사중")
                
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

struct ReportButtonEmoji: View {
    
    
    @State var emoji: String
    @State var text: String
    @State  var isNext = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button {
            text = "✅"
            sleep(1)
            dismiss()
        } label: {
            HStack {
                Image(emoji)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                Text(text)
                    .font(.custom("SF Pro Text", size: 14))
                    .padding(.leading, 5)
            }
        }
        .frame(height: 90)
        .frame(maxWidth: .infinity)
        .foregroundColor(.sesacMint)
    }
}

struct ReportButtonSymbol: View {
    
    
    @State var image: Image
    @State var text: String
    @State  var isNext = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button {
            text = "✅"
            sleep(1)
            dismiss()
        } label: {
            HStack {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 32)
                Text(text)
                    .font(.custom("SF Pro Text", size: 14))
            }
        }
        .frame(height: 90)
        .frame(maxWidth: .infinity)
        .foregroundColor(.sesacMint)
    }
}
