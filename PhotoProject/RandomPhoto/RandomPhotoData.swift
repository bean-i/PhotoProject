//
//  RandomPhotoData.swift
//  PhotoProject
//
//  Created by 이빈 on 1/21/25.
//

import Foundation

struct RandomPhotoData: Decodable {
    let id: String
    let created_at: String
    let urls: PhotoUrl
    let user: User
}

struct User: Decodable {
    let name: String
    let profile_image: ProfileImage
}

struct ProfileImage: Decodable {
    let medium: String
}
