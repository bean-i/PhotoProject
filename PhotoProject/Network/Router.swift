//
//  Router.swift
//  PhotoProject
//
//  Created by 이빈 on 1/21/25.
//

import Foundation
import Alamofire

enum Router {
    
    case photoSearch
    case photoStatistics(id: String)
    case topicPhoto(topic: String)
    case randomPhoto
    case getPhoto(id: String)
    
    var baseURL: String {
        return "https://api.unsplash.com"
    }
    
    var endpoint: URL {
        switch self {
        case .photoSearch:
            return URL(string: baseURL + "/search/photos")!
        case .photoStatistics(let id):
            return URL(string: baseURL + "/photos/\(id)/statistics")!
        case .topicPhoto(let topic):
            return URL(string: baseURL + "/topics/\(topic)/photos")!
        case .randomPhoto:
            return URL(string: baseURL + "/photos/random?count=10")!
        case .getPhoto(let id):
            return URL(string: baseURL + "/photos/\(id)")!
        }
    }
    
    var header: HTTPHeaders {
        return ["Authorization": "Client-ID \(SearchPhotoAPI.clientID)"]
    }
    
    var method: HTTPMethod {
        switch self {
        case .photoSearch:
            return .get
        case .photoStatistics:
            return .get
        case .topicPhoto:
            return .get
        case .randomPhoto:
            return .get
        case .getPhoto:
            return .get
        }
    }

}
