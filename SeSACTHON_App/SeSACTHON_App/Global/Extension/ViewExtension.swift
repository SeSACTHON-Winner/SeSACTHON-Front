//
//  ViewExtension.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/02.
//

import Foundation
import SwiftUI
import Alamofire

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    func fetchMember() -> MemberMO {
        
        let member = MemberMO(id: "IDID", nickname: "Eugene", totalCount: 3, dangerInfoList: [], runningInfo: [])
        
        return member
    }
    
    func fetchDangerList() -> [DangerInfoMO] {
        
        var dangerArr: [DangerInfoMO] = [
            .init(id: "1", latitude: 36.016, longitude: 129.324, picturePath: "/123.png", type: .step),
            .init(id: "2", latitude: 36.017, longitude: 129.325, picturePath: "/124.png", type: .slope),
            .init(id: "3", latitude: 36.018, longitude: 129.326, picturePath: "/125.png", type: .construction),
            .init(id: "4", latitude: 36.019, longitude: 129.327, picturePath: "/126.png", type: .narrow)
        ]
        
        dangerArr.removeAll()
        AF.request("http://35.72.228.224/adaStudy/dangerInfo.php")
            .responseDecodable(of: [DangerInfoMO].self) { response in
                guard let dangerInfoArray = response.value else {
                    print("Failed to decode dangerInfoArray")
                    return
                }
                print(response.value?.first?.latitude)
                dangerArr = response.value!
                print(dangerArr.description)
            }
        return dangerArr
    }
}
