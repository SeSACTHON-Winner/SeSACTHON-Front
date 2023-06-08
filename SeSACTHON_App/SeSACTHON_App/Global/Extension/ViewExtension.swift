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
}
