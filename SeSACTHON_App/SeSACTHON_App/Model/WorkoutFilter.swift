//
//  WorkoutFilter.swift
//  Running
//
//  Created by Lee Jinhee on 2023/06/08.
//

import Foundation

enum WorkoutDate: String, CaseIterable {
    case thisWeek = "This Week"
    case thisMonth = "This Month"
    case thisYear = "This Year"
    
    var granularity: Calendar.Component {
        switch self {
        case .thisWeek:
            return .weekOfMonth //이번 주 날짜의 세분화는 이 달의 주입니다.
        case .thisMonth:
            return .month // 이 달 날짜의 세분화
        case .thisYear:
            return .year // 올해 날짜의 세분화
        }
    }
}
