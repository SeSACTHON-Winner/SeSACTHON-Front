//
//  MemberMO.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/08.
//

import Foundation

class MemberMO: ObservableObject, Identifiable {
    
    @Published var id: Int
    @Published var uid: String
    @Published var nickname: String
    @Published var totalCount: Int
    
    
    init(id: Int, uid: String, nickname: String, totalCount: Int) {
        self.id = id
        self.uid = uid
        self.nickname = nickname
        self.totalCount = totalCount
    }

}
