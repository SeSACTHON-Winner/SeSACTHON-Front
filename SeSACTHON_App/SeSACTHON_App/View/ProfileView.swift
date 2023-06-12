//
//  ProfileView.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/06.
//

import SwiftUI
import Alamofire
import Kingfisher

struct ProfileView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State var nickname: String = ""
    @State var member = MemberMO(id: 0, uid: "dd", nickname: "NICK", totalCount: 4, picturePath: "")
    @State var runningArr: [RunningInfo] = []
    @State var isNickEditable = false
    
    @State var nickText = ""
    
    @State var showPhoto = false
    @State var profileUIimage: UIImage?
    
    var body: some View {
        VStack(spacing: 0) {
            Color.black.frame(height: 50)
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
                Text("PROFILE")
                    .font(.custom("SF Pro Text", size: 32))
                    .foregroundColor(.white)
                    .italic()
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom)
            .padding(.horizontal)
            .background(.black)
            Color.black.frame(height: 20)
                .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
                .shadow(radius: 3, x: 0 ,y: 4)
            HStack(spacing: 29) {
                
                // MARK: - profile image
                KFImage(URL(string: "http://35.72.228.224/sesacthon/\(member.picturePath)")!)
                    .placeholder { //플레이스 홀더 설정
                        Image(systemName: "map")
                    }.retry(maxCount: 3, interval: .seconds(5)) //재시도
                    .onSuccess {r in //성공
                        print("succes: \(r)")
                    }
                    .onFailure { e in //실패
                        print("Fail : \(member.picturePath)")
                        print("failure: \(e)")
                        
                    }
                    .resizable()
                    .scaledToFit()
                    .frame(width: 126)
                    .clipShape(Circle())
                    .padding(.leading, 30)
                    .onTapGesture {
                        showPhoto = true
                    }
                    .fullScreenCover(isPresented: $showPhoto) {
                        SUImagePicker(sourceType: UIImagePickerController.SourceType.photoLibrary) { (image) in
                            
                            // MARK: - ImageUpload
                            self.profileUIimage = image
                            print(image)
                            var url = URL(string: "http://35.72.228.224/sesacthon/imageSave.php")!
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyMMddHHmmss"

                            let currentDate = Date()
                            let formattedDate = dateFormatter.string(from: currentDate)
                            let photoName = "\(member.nickname)\(formattedDate)"
                            var params = ["uid" : UserDefaults.standard.string(forKey: "uid"), "picture_path" : "\(member.nickname)"] as Dictionary
                                AF.upload(multipartFormData: { multipartFormData in
                                        if let imageData = image.jpegData(compressionQuality: 0.5) {
                                            multipartFormData.append(imageData, withName: "photo", fileName: "\(photoName).jpg", mimeType: "image/jpeg")
                                        }
                                    }, to: url).response { response in
                                    switch response.result {
                                    case .success(let value):
                                        if let data = value {
                                            // Process the response data as needed
                                            let responseString = String(data: data, encoding: .utf8)
                                            print("Response: \(responseString ?? "")")
                                        }
                                        print("Photo uploaded successfully")
                                        
                                    case .failure(let error):
                                        print("Photo upload failed with error: \(error)")
                                    }
                                }
                            url = URL(string: "http://35.72.228.224/sesacthon/memberInfo.php")!
                            let uid = UserDefaults.standard.string(forKey: "uid") ?? ""
                            params = ["picture_path" : "images/\(photoName).jpg", "uid" : uid] as Dictionary
                            AF.request(url, method: .put, parameters: params).responseString {
                                print($0.result)
                                fetchMember { result in
                                    switch result {
                                    case .success(let data):
                                        member = data
                                    case .failure(let error):
                                        print("\n\n\nmember\n\n\n")
                                        print(error)
                                    }
                                }
                            }
                        }
                        .ignoresSafeArea()
                    }
                
                VStack {
                    HStack {
                        
                        Button {
                            isNickEditable = true
                        } label: {
                            Image(systemName: "highlighter")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16)
                        }
                        
                        // MARK: - Nickname
                        if isNickEditable {
                            TextField(member.nickname, text: $nickname)
                                .font(.system(size: 24))
                                .fontWeight(.bold)
                                .onSubmit {
                                    
                                    let url = "http://35.72.228.224/sesacthon/memberInfo.php"
                                    let uid = UserDefaults.standard.string(forKey: "uid") ?? ""
                                    print("uid : \(uid)")
                   
                                    let params = ["nickname" : self.nickname, "uid" : uid] as Dictionary
                                    AF.request(url, method: .put, parameters: params).responseString {
                                        print($0.result)
                                        fetchMember { result in
                                            switch result {
                                            case .success(let data):
                                                member = data
                                                print(data.nickname)
                                                nickText = data.nickname
                                                isNickEditable = false
                                            case .failure(let error):
                                                print("\n\n\nmember\n\n\n")
                                                print(error)
                                            }
                                        }
                                    }
                                    
                                    
                                }
                        } else {
                            Text(member.nickname)
                                .font(.system(size: 24))
                                .fontWeight(.bold)
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    HStack {
                        Text("총 도움")
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                        Image(systemName: "\(member.totalCount).circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 21)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.top, 69)
            .padding(.bottom, 60)
            
            HStack {
                Text("최근 활동")
                Spacer()
            }
            .padding(.leading, 30)
            .padding(.vertical)
            
            ScrollView {
                
                ForEach(runningArr, id: \.self) { runninginfo in
                    RunRecentView(runData: runninginfo)
                }
            }
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
        .onAppear {
            
            fetchMember { result in
                switch result {
                case .success(let data):
                    member = data
                    print("data.nickname : \(data.nickname)")
                    nickText = data.nickname
                case .failure(let error):
                    print(error)
                }
            }
            
            
            fetchRunningInfo { result in
                switch result {
                case .success(let data):
                    runningArr = data
                case .failure(let error):
                    print(error)
                }
            }
            
        }
    }
}

extension ProfileView {
    
    func fetchMember(completion: @escaping (Result<MemberMO, AFError>) -> Void) {
        
        let url = "http://35.72.228.224/sesacthon/memberInfo.php"
        let params = ["uid" : UserDefaults.standard.string(forKey: "uid")] as Dictionary
        
        AF.request(url, method: .get, parameters: params)
            .responseDecodable(of: MemberMO.self) {
                completion($0.result)
                print($0.result)
                
            }
    }
    
    func fetchRunningInfo(completion: @escaping (Result<[RunningInfo], AFError>) -> Void) {
        
        let url = "http://35.72.228.224/sesacthon/runningInfo.php"
        let params = ["uid" : UserDefaults.standard.string(forKey: "uid")] as Dictionary
        
        AF.request(url, method: .get, parameters: params)
            .responseDecodable(of: [RunningInfo].self) {
                completion($0.result)
                print($0.result)
            }
    }
    
    private func customListItem(profileImage: Image) -> some View {
        
        return ZStack {
            Color.init(hex: "f5f5f5")
                .frame(height: 160)
                .cornerRadius(14)
                .padding(.top, 20)
                .padding(.horizontal, 10)
                .shadow(radius: 3, x: 2, y: 2)
            
            VStack {
                HStack {
                    Color.black
                        .frame(width: 63,height: 63)
                        .cornerRadius(10)
                    VStack(alignment: .leading, spacing: 11) {
                        Text("2023.06.17")
                            .font(.system(size: 24))
                            .fontWeight(.bold)
                        Text("수요일 효자시장 코스")
                            .font(.system(size: 14))
                            .fontWeight(.medium)
                    }
                    .padding(.leading, 27)
                    Spacer()
                }
                .padding(.leading, 27)
                .padding(.top, 27)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("1.09")
                            .font(.system(size: 24))
                            .fontWeight(.bold)
                        Text("Km")
                    }
                    VStack(alignment: .leading) {
                        Text("8'24'")
                            .font(.system(size: 24))
                            .fontWeight(.bold)
                        Text("Pace")
                    }
                    .padding(.leading, 40)
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("09:13")
                            .font(.system(size: 24))
                            .fontWeight(.bold)
                        Text("Time")
                    }
                    .padding(.leading, 10)
                    Spacer()
                    VStack(alignment: .leading) {
                        Image(systemName: "1.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 21)
                        Text("Help")
                    }
                }
                
                .padding(.horizontal, 26)
            }
        }
    }
}


//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            ProfileView()
//        }
//    }
//}
