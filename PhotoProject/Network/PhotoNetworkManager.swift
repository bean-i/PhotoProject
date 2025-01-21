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
                            completionHandler: @escaping (PhotoSearchData) -> Void) {
        
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
            }
        }
    }
    
    // Photo Statistics API
    func getPhotoStatisticsData(api: Router,
                                completionHandler: @escaping (PhotoDetailData) -> Void) {
        
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
            }
        }
    }
    
    // Topic's Photo API
    func getTopicPhotoData(api: Router,
                           completionHandler: @escaping ([Photo]) -> Void) {
        
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
            }
        }
    }
    
}
