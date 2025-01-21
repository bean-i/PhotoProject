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
        }
    }

}
