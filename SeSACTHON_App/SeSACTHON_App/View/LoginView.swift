//
//  LoginView.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/07.
//

import SwiftUI
import AuthenticationServices
import Alamofire

struct LoginView: View {
    
    @State var isLogin = false
    
    var body: some View {
        ZStack {
            Color.clear
                .overlay {
                    Image("LoginScreen")
                }
            VStack {
                Spacer()
                AppleSigninButton(isLogin: $isLogin)
            }
            .padding(.bottom, 60)
            
        }
        .fullScreenCover(isPresented: $isLogin) {
            HomeView()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct AppleSigninButton : View{
    
    @Binding var isLogin: Bool
    
    var body: some View{
        SignInWithAppleButton(
            onRequest: { request in
                request.requestedScopes = [.fullName, .email]
            },
            onCompletion: { result in
                switch result {
                case .success(let authResults):
                    print("Apple Login Successful")
                    switch authResults.credential{
                    case let appleIDCredential as ASAuthorizationAppleIDCredential:
                        // 계정 정보 가져오기
                        let UserIdentifier = appleIDCredential.user
                        let fullName = appleIDCredential.fullName
                        let name =  (fullName?.familyName ?? "") + (fullName?.givenName ?? "")
                        let email = appleIDCredential.email
                        let IdentityToken = String(data: appleIDCredential.identityToken!, encoding: .utf8)
                        let AuthorizationCode = String(data: appleIDCredential.authorizationCode!, encoding: .utf8)
                        
                        let url = "http://35.72.228.224/sesacthon/memberInfo.php"
                        let params = ["uid" : UserIdentifier, "nickname" : "nothing", "total_count" : 0] as Dictionary
                        AF.request(url, method: .post, parameters: params).responseString{
                            print($0)
                        }
                        UserDefaults.standard.setValue(UserIdentifier, forKey: "uid")
                        print("UserDefaults: \(UserDefaults.standard.string(forKey: "uid") ?? "Nothing")")
                        
                    default:
                        break
                    }
                    UserDefaults.standard.setValue(true, forKey: "login")
                    isLogin = true
                case .failure(let error):
                    print(error.localizedDescription)
                    print("error")
                }
            }
        )
        .frame(width : UIScreen.main.bounds.width * 0.9, height:50)
        .cornerRadius(5)
    }
}
