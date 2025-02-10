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
        let configurePhotoData: Observable<PhotoDetailData?> = Observable(nil)
        let configureUserData: Observable<RandomPhotoData?> = Observable(nil)
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
            // 이 경우, 네트워크 통신 안의 output 설정 코드가 있는데
            // 만약 네트워크 통신이 굉장히 빨리 돼서 (output 대응 코드가 있는)뷰컨의 ViewDidLoad가 채 실행되기 전에
            // 네트워크 통신이 끝난다면, 제대로 적용이 안 될 수 있을 것 같다.
            // -> 해당 코드의 output 대응 코드를 lazyBind가 아닌 bind로 설정하도록..
            self?.fetchData()
            self?.fetchUserData()
        }
    }
    
    private func fetchData() {
        print(input.photoID.value)
        PhotoNetworkManager.shared.getPhotoData(api: .photoStatistics(id: input.photoID.value), type: PhotoDetailData.self) { [weak self] value in
            self?.output.configurePhotoData.value = value
        } failHandler: { [weak self] statusCode in
            self?.output.configureError.value = statusCode
        }
    }
    
    private func fetchUserData() {
        PhotoNetworkManager.shared.getPhotoData(api: .getPhoto(id: input.photoID.value), type: RandomPhotoData.self) { [weak self] value in
            self?.output.configureUserData.value = value
        } failHandler: { [weak self] statusCode in
            self?.output.configureError.value = statusCode
        }
    }
    
}
