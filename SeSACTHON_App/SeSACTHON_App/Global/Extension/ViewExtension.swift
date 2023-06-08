//
//  ViewExtension.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/02.
//

import Foundation
import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    func fetchMember() -> MemberMO {
        
        let member = MemberMO(id: "IDID", nickname: "Eugene", totalCount: 3, dangerInfoList: [], runningInfo: [])
        
        return member
    }
    
    func fetchDangerList() -> [DangerInfoMO] {
        
        let dangerArr: [DangerInfoMO] = [
            .init(id: "1", latitude: 36.016, longtitude: 129.324, picturePath: "/123.png", type: .step),
            .init(id: "2", latitude: 36.017, longtitude: 129.325, picturePath: "/124.png", type: .slope),
            .init(id: "3", latitude: 36.018, longtitude: 129.326, picturePath: "/125.png", type: .construction),
            .init(id: "4", latitude: 36.019, longtitude: 129.327, picturePath: "/126.png", type: .narrow)
        ]
        
        return dangerArr
    }
}
