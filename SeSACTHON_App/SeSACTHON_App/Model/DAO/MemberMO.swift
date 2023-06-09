//
//  MemberMO.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/08.
//

import Foundation

class MemberMO: ObservableObject, Identifiable, Codable {
    
    var id: Int
    var uid: String
    var nickname: String
    var totalCount: Int
    
    
    init(id: Int, uid: String, nickname: String, totalCount: Int) {
        self.id = id
        self.uid = uid
        self.nickname = nickname
        self.totalCount = totalCount
    }

}


