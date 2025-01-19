//
//  PhotoSearchData.swift
//  PhotoProject
//
//  Created by 이빈 on 1/17/25.
//

import Foundation

struct PhotoSearchData: Decodable {
    let total: Int
    let totalPages: Int
    let results: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

struct Photo: Decodable {
    let id: String
    let urls: PhotoUrl
    let likes: Int
}

struct PhotoUrl: Decodable {
    let originalURL: String
    
    enum CodingKeys: String, CodingKey {
        case originalURL = "raw"
    }
}
