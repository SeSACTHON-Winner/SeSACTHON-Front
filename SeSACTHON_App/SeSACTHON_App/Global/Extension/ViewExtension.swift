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
    
    func fetchAnnotationItems() -> [DangerInfoMO] {
        // API가 완성되면 여기에 호출 코드 작성
        let dangerList: [DangerInfoMO] = [
            .init(id: "1", latitude: 36.015, longtitude: 129.323, picturePath: "wow1.png", type: .slope),
            .init(id: "2", latitude: 36.016, longtitude: 129.324, picturePath: "wow2.png", type: .step),
            .init(id: "3", latitude: 36.017, longtitude: 129.325, picturePath: "wow3.png", type: .construction),
            .init(id: "4", latitude: 36.018, longtitude: 129.326, picturePath: "wow4.png", type: .narrow)
        ]
        
       
        return dangerList
    }
    
    func fetchMember(id: String) -> MemberMO {
        
        var member = MemberMO(
            id: "testid", nickname: "testnickname", totalCount: 0,
            dangerInfoList: [.init(id: "1", latitude: 36.015, longtitude: 129.323, picturePath: "wow1.png", type: .step)],
            runningInfo: []
        )
        
        return member
    }
    
}
