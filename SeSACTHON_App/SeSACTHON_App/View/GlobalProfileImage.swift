//
//  GlobalProfileImage.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/13.
//

import Foundation
import Kingfisher
import SwiftUI

class GlobalProfileImage { 
    
    static var profile = KFImage(URL(string: "http://35.72.228.224/sesacthon/images/test.jpg")!)
            .placeholder { //플레이스 홀더 설정
                Image(systemName: "map")
            }.retry(maxCount: 3, interval: .seconds(5)) //재시도
            .onSuccess {r in //성공
                print("succes: \(r)")
            }
            .onFailure { e in //실패
                print("failure: \(e)")
            }
    
    static func setProfile(imagePath: String) {
        self.profile = KFImage(URL(string: "http://35.72.228.224/sesacthon/\(imagePath)")!)
            .placeholder { //플레이스 홀더 설정
                Image(systemName: "map")
            }.retry(maxCount: 3, interval: .seconds(5)) //재시도
            .onSuccess {r in //성공
                print("succes: \(r)")
            }
            .onFailure { e in //실패
                print("failure: \(e)")
            }
    }
}
