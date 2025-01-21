//
//  DateFormatter+.swift
//  PhotoProject
//
//  Created by 이빈 on 1/21/25.
//

import Foundation

extension DateFormatter {
    
//    2024-12-15T07:10:06Z
    
    static let isoFormat = { str in
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = .withInternetDateTime
        return formatter.date(from: str)
    }
    
    static let dateFromString = { str in
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.locale = Locale(identifier: "UTC")
        return formatter.date(from: str)
    }
    
    static let stringFromDate = { date in
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter.string(from: date)
    }
    
}
