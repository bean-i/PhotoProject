//
//  NetworkManager.swift
//  PhotoProject
//
//  Created by 이빈 on 1/17/25.
//

import UIKit
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() { }
    
    func getPhotoSearchData(params: Parameters, completionHandler: @escaping (PhotoSearchData) -> Void) {
        let url = "https://api.unsplash.com/search/photos?query=\(params.query)&page=\(params.page)&per_page=\(params.per_page)&order_by=\(params.order_by)&client_id=\(params.client_id)"
        
//        AF.request(url, method: .get).responseString { value in
//            print(value)
//        }
        
        AF.request(url, method: .get).responseDecodable(of: PhotoSearchData.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}
