//
//  ReportView.swift
//  SeSACTHON_Watch Watch App
//
//  Created by ChoiYujin on 2023/06/04.
//

import SwiftUI
import Alamofire
import WatchConnectivity

struct ReportView: View {
    
    @State var isNext = false
    @Environment(\.dismiss) private var dismiss
    @State var emoji = ""
    
    @ObservedObject var wsManager = WatchSessionManager.sharedManager

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
                ReportButtonEmoji(emoji: "slope", dangertype: .slope)
                ReportButtonEmoji(emoji: "step", dangertype: .step)
                ReportButtonEmoji(emoji: "narrow", dangertype: .narrow)
                ReportButtonEmoji(emoji: "construction", dangertype: .construct)
                
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
    @State  var isNext = false
    @State var dangertype: dangerType
    @Environment(\.dismiss) private var dismiss
    
    @State var coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    @State var locattionmanager = WatchLocationDataManager()
    @ObservedObject var wsManager = WatchSessionManager.sharedManager

    var body: some View {
            Button {
                coordinate = locattionmanager.returnLocation()
                
                var url = URL(string: "http://35.72.228.224/sesacthon/dangerInfo.php")!
                let uid = UserDefaults.standard.string(forKey: "uid")
                let params = ["uid" : uid, "latitude" : coordinate.latitude, "longitude" : coordinate.longitude, "type" : returnEngRaw()] as Dictionary
                
                AF.request(url, method: .post, parameters: params).responseString {
                    print($0)
                }
                //라딘 수정
                wsManager.sendPlusHelpCount()
                sleep(1)
        
                dismiss()
            } label: {
                HStack {
                    Image("icon_\(emoji)_main")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                    Text(dangertype.rawValue)
                        .font(.custom("SF Pro Text", size: 14))
                        .padding(.leading, 5)
                }
        }
        .frame(height: 90)
        .frame(maxWidth: .infinity)
        .foregroundColor(.sesacMint)

    }
    
    func returnEngRaw() -> String {
        switch self.dangertype {
        case .step:
            return "step"
        case .slope:
            return "slope"
        case .narrow:
            return "narrow"
        case .construct:
            return "construct"
        }
    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String: Any]) {
        if let uid = userInfo["uid"] as? String {
            // Use the `uid` value in your watch app
            UserDefaults.standard.setValue(uid, forKey: "uid")
        }
    }
    
}

enum dangerType: String {
    case slope = "경사도"
    case step = "높은 턱"
    case narrow = "좁은길"
    case construct = "공사중"
}
