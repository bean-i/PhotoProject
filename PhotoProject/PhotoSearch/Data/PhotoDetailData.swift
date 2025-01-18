//
//  PhotoDetailData.swift
//  PhotoProject
//
//  Created by 이빈 on 1/18/25.
//

import Foundation

struct PhotoDetailData: Decodable {
    let id: String
    let downloads: Download
    let views: Views
}

struct Download: Decodable {
    let total: Int
}

struct Views: Decodable {
    let total: Int
}
