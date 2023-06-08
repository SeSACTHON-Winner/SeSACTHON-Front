//
//  MemberMO.swift
//  SeSACTHON_App
//
//  Created by ChoiYujin on 2023/06/08.
//

import Foundation

class MemberMO: ObservableObject, Identifiable {
    
    @Published var id: String
    @Published var nickname: String
    @Published var totalCount: Int
    @Published var dangerInfoList: [DangerInfoMO]
    @Published var runningInfo: [RunningInfo]
    
    init(id: String, nickname: String, totalCount: Int, dangerInfoList: [DangerInfoMO], runningInfo: [RunningInfo]) {
        self.id = id
        self.nickname = nickname
        self.totalCount = totalCount
        self.dangerInfoList = dangerInfoList
        self.runningInfo = runningInfo
    }
}
