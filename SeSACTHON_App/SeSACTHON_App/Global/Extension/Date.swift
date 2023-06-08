//
//  Date.swift
//  Running
//
//  Created by Ah lucie nous gênes 🍄 on 02/02/2023.
//

import Foundation

extension Date {
        func formattedApple() -> String {
        
        // 날짜 형식 초기화 중
        let formatter = DateFormatter()
        
        // 달력 초기화 중
        let calendar = Calendar.current
        
        // 현재 날짜 전후의 1주일 시간 제한 설정
        let oneWeekAgo = calendar.startOfDay(for: Date.now.addingTimeInterval(-7*24*3600))
        let oneWeekAfter = calendar.startOfDay(for: Date.now.addingTimeInterval(7*24*3600))
        
            // 만약 날짜가 오늘이라면, 우리는 짧은 시간 형식을 되돌려보낸다.
        if calendar.isDateInToday(self) {
            return formatted(date: .omitted, time: .shortened)
            
            // 날짜가 어제나 내일이라면 상대적인 형식을 사용한다
        } else if calendar.isDateInYesterday(self) || calendar.isDateInTomorrow(self) {
            formatter.doesRelativeDateFormatting = true
            formatter.dateStyle = .full
            
            // 날짜가 평일일일 경우 요일명을 사용한다
        } else if self > oneWeekAgo && self < oneWeekAfter {
            formatter.dateFormat = "EEEE"
            
            // 날짜가 현재 연도일 경우 월 일 형식을 사용합니다.
        } else if calendar.isDate(self, equalTo: .now, toGranularity: .year) {
            formatter.dateFormat = "d MMM"
            
            // 그렇지 않으면, "년월일"이라는 전체 형식을 사용합니다.
        } else {
            formatter.dateFormat = "d MMM y"
        }
        
        return formatter.string(from: self)
    }
}
