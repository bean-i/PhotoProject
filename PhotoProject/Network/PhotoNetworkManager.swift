//
//  NetworkManager.swift
//  PhotoProject
//
//  Created by 이빈 on 1/17/25.
//

import Foundation
import Alamofire

class PhotoNetworkManager {
    static let shared = PhotoNetworkManager()
    
    private init() { }
    
    // Photo Search API
    func getPhotoSearchData(api: Router,
                            params: queryParameter,
                            completionHandler: @escaping (PhotoSearchData) -> Void,
                            failHandler: @escaping () -> Void) {
        
        AF.request(api.endpoint,
                   method: api.method,
                   parameters: params,
                   headers: api.header)
        .validate(statusCode: 200..<500)
        .responseDecodable(of: PhotoSearchData.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                print(error)
                failHandler()
            }
        }
    }
    
    // Photo Statistics API
    func getPhotoStatisticsData(api: Router,
                                completionHandler: @escaping (PhotoDetailData) -> Void,
                                failHandler: @escaping () -> Void) {
        
        AF.request(api.endpoint,
                   method: api.method,
                   headers: api.header)
        .validate(statusCode: 200..<500)
        .responseDecodable(of: PhotoDetailData.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                print(error)
                failHandler()
            }
        }
    }
    
    // Topic's Photo API
    func getTopicPhotoData(api: Router,
                           completionHandler: @escaping ([Photo]) -> Void,
                           failHandler: @escaping () -> Void) {
        
        AF.request(api.endpoint,
                   method: api.method,
                   headers: api.header)
        .validate(statusCode: 200..<500)
        .responseDecodable(of: [Photo].self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                print(error)
                failHandler()
            }
        }
    }
    
    // Random Photo
    func getRandomPhotoData(api: Router,
                            completionHandler: @escaping ([RandomPhotoData]) -> Void) {
        AF.request(api.endpoint,
                   method: api.method,
                   headers: api.header)
        .validate(statusCode: 200..<500)
        .responseDecodable(of: [RandomPhotoData].self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
