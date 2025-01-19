//
//  NetworkManager.swift
//  PhotoProject
//
//  Created by 이빈 on 1/17/25.
//

import UIKit
import Alamofire

class PhotoNetworkManager {
    static let shared = PhotoNetworkManager()
    
    private init() { }
    
    // Photo Search API
    func getPhotoSearchData(params: Parameters, completionHandler: @escaping (PhotoSearchData) -> Void) {
        let url = "https://api.unsplash.com/search/photos?query=\(params.query)&page=\(params.page)&per_page=\(params.per_page)&order_by=\(params.order_by)&client_id=\(params.client_id)"
        
        AF.request(url, method: .get).responseDecodable(of: PhotoSearchData.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // Photo Statistics API
    func getPhotoStatisticsData(imageId: String, completionHandler: @escaping (PhotoDetailData) -> Void) {
        let url = "https://api.unsplash.com/photos/\(imageId)/statistics?client_id=\(SearchPhotoAPI.clientID)"
        
        AF.request(url, method: .get).responseDecodable(of: PhotoDetailData.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
