//
//  TopicViewController.swift
//  PhotoProject
//
//  Created by 이빈 on 1/17/25.
//

import UIKit

class TopicViewController: BaseViewController {
    
    var mainView = TopicView()
    
    override func loadView() {
        view = mainView
    }
    
    override func configureView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "OUR TOPIC"
        
        for idx in 0..<mainView.topics.count {
            mainView.topicViews[idx].delegate = self
            mainView.topicViews[idx].getData(topic: mainView.topics[idx])
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
