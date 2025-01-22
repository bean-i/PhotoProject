//
//  NetworkManager.swift
//  PhotoProject
//
//  Created by 이빈 on 1/17/25.
//

import Foundation
import Alamofire

final class PhotoNetworkManager {
    static let shared = PhotoNetworkManager()
    
    private init() { }
    
    func getPhotoData<T: Decodable>(api: Router,
                                    type: T.Type,
                                    params: queryParameter? = nil,
                                    completionHandler: @escaping (T) -> Void,
                                    failHandler: @escaping (StatusCode) -> Void) {
        
        AF.request(api.endpoint,
                   method: api.method,
                   parameters: params,
                   headers: api.header)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                switch error.responseCode {
                case 400:
                    failHandler(StatusCode.badRequest)
                case 401:
                    failHandler(StatusCode.unauthorized)
                case 403:
                    failHandler(StatusCode.forbidden)
                case 404:
                    failHandler(StatusCode.notFound)
                case 500, 503:
                    failHandler(StatusCode.serverError)
                default:
                    return
                }
            }
        }
    }
    
}
