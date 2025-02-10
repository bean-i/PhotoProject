//
//  TopicViewController.swift
//  PhotoProject
//
//  Created by 이빈 on 1/17/25.
//

import UIKit

final class TopicViewController: BaseViewController {
    
    private var mainView = TopicView()
    
    private let group = DispatchGroup()
    
    let topics = [
        TopicQuery.goldenHour,
        TopicQuery.business,
        TopicQuery.architecture
    ]
    
    override func loadView() {
        view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func configureView() {
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        title = "OUR TOPIC"
        
        for idx in 0..<topics.count {
            mainView.topicViews[idx].delegate = self
            group.enter()
            // 네트워크 통신 + 토픽커스텀뷰에 데이터 넘겨주기
            PhotoNetworkManager.shared.getPhotoData(api: .topicPhoto(topic: topics[idx].rawValue), type: [Photo].self) { value in
                self.mainView.topicViews[idx].topicData = value
                self.group.leave()
            } failHandler: { statusCode in
                self.showAlert(
                    title: statusCode.title,
                    message: statusCode.description,
                    cancel: false) {
                        print("alert")
                    }
                self.group.leave()
            }

        }
        
        group.notify(queue: .main) {
            for idx in 0..<self.topics.count {
                self.mainView.topicViews[idx].topicCollectionView.reloadData()
            }
        }
    }
}

extension TopicViewController: CustomCollectionViewDelegate {
    func didSelectItemData(data: Photo) {
        // 화면 전환
        let vc = PhotoDetailViewController()
        print("토픽 화면: 화면 전환")
        vc.viewModel.input.photoID.value = data.id
        vc.viewModel.output.photoURL.value = data.urls.originalURL
        navigationController?.pushViewController(vc, animated: true)
    }
}
