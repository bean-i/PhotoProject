//
//  TopicViewController.swift
//  PhotoProject
//
//  Created by 이빈 on 1/17/25.
//

import UIKit

// topic id query
enum TopicQuery: String {
    case architecture = "architecture-interior"
    case goldenHour = "golden-hour"
    case wallpapers
    case nature
    case render3D = "3d-renders"
    case travel
    case pattern = "textures-patterns"
    case street = "street-photography"
    case film
    case archival
    case experimental
    case animals
    case fashionBeauty = "fashion-beauty"
    case people
    case business = "business-work"
    case foodDrink = "food-drink"
    
    var description: String {
        switch self {
        case .architecture:
            return "건축 및 인테리어"
        case .goldenHour:
            return "골든 아워"
        case .wallpapers:
            return "배경 화면"
        case .nature:
            return "자연"
        case .render3D:
            return "3D 렌더링"
        case .travel:
            return "여행하다"
        case .pattern:
            return "텍스쳐 및 패턴"
        case .street:
            return "거리 사진"
        case .film:
            return "필름"
        case .archival:
            return "기록의"
        case .experimental:
            return "실험적인"
        case .animals:
            return "동물"
        case .fashionBeauty:
            return "패션 및 뷰티"
        case .people:
            return "사람"
        case .business:
            return "비즈니스 및 업무"
        case .foodDrink:
            return "식음료"
        }
    }
}

class TopicViewController: BaseViewController {
    
    var mainView = TopicView()
    
    override func loadView() {
        view = mainView
    }
    
    override func configureView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        title = "OUR TOPIC"
        
        for idx in 0..<mainView.topics.count {
            mainView.topicViews[idx].delegate = self
            mainView.topicViews[idx].getData(topic: mainView.topics[idx]) // 이 부분 데이터 한번에 뜨게 수정해보기!!!
        }
    }
}

extension TopicViewController: CustomCollectionViewDelegate {
    func didSelectItemData(data: Photo) {
        // 화면 전환
        let vc = PhotoDetailViewController()
        vc.photoId = data.id
        vc.photoURL = data.urls.originalURL
        navigationController?.pushViewController(vc, animated: true)
    }
}
