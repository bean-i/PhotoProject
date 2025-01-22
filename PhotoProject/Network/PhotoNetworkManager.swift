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
    
    func getPhotoData<T: Decodable>(api: Router,
                         type: T.Type,
                         params: queryParameter? = nil,
                         completionHandler: @escaping (T) -> Void,
                         failHandler: @escaping () -> Void) {
        
        AF.request(api.endpoint,
                   method: api.method,
                   parameters: params,
                   headers: api.header)
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                print(error)
                failHandler()
            }
        }
    }
    
}
