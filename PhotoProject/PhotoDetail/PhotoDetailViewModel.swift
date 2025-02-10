//
//  PhotoDetailViewModel.swift
//  PhotoProject
//
//  Created by 이빈 on 2/10/25.
//

import Foundation
import Alamofire

class PhotoDetailViewModel: BaseViewModel {
    
    struct Input {
        let viewDidLoadTrigger: Observable<Void> = Observable(())
        let photoID: Observable<String> = Observable("")
    }
    
    struct Output {
        let viewDidLoadTrigger: Observable<Void> = Observable(())
        let photoURL: Observable<String> = Observable("")
        let configureData: Observable<PhotoDetailData?> = Observable(nil)
        let configureError: Observable<StatusCode?> = Observable(nil)
    }
    
    private(set) var input: Input
    private(set) var output: Output
    
    init() {
        input = Input()
        output = Output()
        transform()
    }
    
    func transform() {
        input.viewDidLoadTrigger.lazyBind { [weak self] _ in
            self?.output.viewDidLoadTrigger.value = ()
        }
        
        input.photoID.lazyBind { [weak self] _ in
            self?.fetchData()
        }
    }
    
    private func fetchData() {
        print(input.photoID.value)
        PhotoNetworkManager.shared.getPhotoData(api: .photoStatistics(id: input.photoID.value), type: PhotoDetailData.self) { value in
            self.output.configureData.value = value
        } failHandler: { statusCode in
            self.output.configureError.value = statusCode
        }
    }
    
}
