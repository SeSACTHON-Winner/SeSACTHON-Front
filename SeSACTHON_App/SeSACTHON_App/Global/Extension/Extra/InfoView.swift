//
//  InfoView.swift
//  Running
//
//  Created by Ah lucie nous gênes 🍄 on 12/02/2023.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.dismiss) var dismiss
    @State var showShareSheet = false
    
    let welcome: Bool

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .center) {
                    VStack(spacing: 0) {
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 70, height: 70)
                            .cornerRadius(15)
                            .padding(.bottom)
                        Text((welcome ? "Welcome to\n" : "") + NAME)
                            .font(.largeTitle.bold())
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 5)
                    }
                }
                .padding(.bottom, 30)
                

                InfoRow(systemName: "map", title: "경로 찾기", description: "건강 앱에 저장된 모든 경로를 맵에서 확인할 수 있습니다.")
                InfoRow(systemName: "record.circle", title: "운동 기록", description: "주행 기록, 걷기 및 경로 업데이트 실시간 확인할 수 있습니다.")

                Spacer()
                
                if welcome {
                    Button {
                        dismiss()
                    } label: {
                        Text("Continue")
                            .bigButton()
                    }
                }
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    if welcome {
                        Text("")
                    }
                }
            }
        }
        .interactiveDismissDisabled(welcome)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
            .sheet(isPresented: .constant(true)) {
                InfoView(welcome: true)
            }
    }
}

struct InfoRow: View {
    let systemName: String
    let title: String
    let description: String
    
    var body: some View {
        HStack {
            Image(systemName: systemName)
                .font(.title)
                .foregroundColor(.accentColor)
                .frame(width: 50, height: 50)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(description)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical)
    }
}


