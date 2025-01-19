//
//  TopicView.swift
//  PhotoProject
//
//  Created by 이빈 on 1/19/25.
//

import UIKit
import SnapKit

class TopicView: BaseView {
    
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    let topicView = TopicCustomView()
    
    let topics = [
        TopicQuery.goldenHour,
        TopicQuery.business,
        TopicQuery.architecture
    ]
    
    let topicViews = [
        TopicCustomView(),
        TopicCustomView(),
        TopicCustomView()
    ]
    
    override func configureHierarchy() {
        topicViews.forEach { stackView.addArrangedSubview($0) }
        scrollView.addSubview(stackView)
        addSubview(scrollView)
    }
    
    override func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView.snp.width)
        }
        
        topicViews.forEach { view in
            view.snp.makeConstraints { make in
                make.height.equalTo(300)
            }
        }
    }
    
    override func configureView() {
        stackView.spacing = 10
        stackView.axis = .vertical
    }
}
