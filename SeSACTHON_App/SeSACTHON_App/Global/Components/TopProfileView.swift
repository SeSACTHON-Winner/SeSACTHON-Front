//
//  TopProfileView.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/04.
//

// MARK: - 디자인 계속 변경될 예정

import SwiftUI
import Alamofire
import Kingfisher

struct TopProfileView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State var title = ""
    @State var imagePath = "images/default.png"
    
    @EnvironmentObject var vm: WorkoutViewModel

    var body: some View {
        
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 10, height: 16)
                    .foregroundColor(.white)
                    .padding(.trailing, 10)
            }
            Text(title)
                .font(.custom("SF Pro Text", size: 32))
                .foregroundColor(.white)
                .italic()
            Spacer()
            KFImage(URL(string: "http://35.72.228.224/sesacthon/\(imagePath)")!)
                .placeholder { //플레이스 홀더 설정
                    Image(systemName: "map")
                }.retry(maxCount: 3, interval: .seconds(5)) //재시도
                .onSuccess {r in //성공
                    print("succes: \(r)")
                }
                .onFailure { e in //실패
                    print("failure: \(e)")
                }
                .resizable()
                .frame(width: 34, height: 34)
                .clipShape(Circle())
                .padding(.leading)
                .onTapGesture {
                    vm.showRunListView = true
                }
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom)
        .background(.black)
        .onAppear {
            var url = URL(string: "http://35.72.228.224/sesacthon/profileImage.php")!
            let params = ["uid" : UserDefaults.standard.string(forKey: "uid")] as Dictionary
            AF.request(url, method: .get, parameters: params).responseString { picturePath in
                print(picturePath)
                self.imagePath = picturePath.value ?? "images/default.png"
            }
            print("KFImage : \(GlobalProfilePath.picture_path)")
        }
    }
}

struct TopProfileView_Previews: PreviewProvider {
    static var previews: some View {
        TopProfileView()
    }
}
