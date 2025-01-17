//
//  NumberFormatter+.swift
//  PhotoProject
//
//  Created by 이빈 on 1/17/25.
//

import Foundation

extension NumberFormatter {
    
    static let decimal = { value in
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: value)
    }
    
}
