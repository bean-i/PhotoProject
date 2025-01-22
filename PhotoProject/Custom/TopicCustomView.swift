//
//  TopicCustomView.swift
//  PhotoProject
//
//  Created by 이빈 on 1/19/25.
//

import UIKit
import SnapKit

final class TopicCustomView: BaseView {
    
    // MARK: - Properties
    private let topicLabel = UILabel()
    let topicCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    var topicData: [Photo] = []
    weak var delegate: CustomCollectionViewDelegate?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCollectionView()
    }
    
    // MARK: - ConfigureViews
    override func configureHierarchy() {
        addSubview(topicLabel)
        addSubview(topicCollectionView)
    }
    
    override func configureLayout() {
        topicLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().inset(15)
        }
        
        topicCollectionView.snp.makeConstraints { make in
            make.top.equalTo(topicLabel.snp.bottom).offset(15)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(250)
            make.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        topicLabel.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    private func configureCollectionView() {
        topicCollectionView.delegate = self
        topicCollectionView.dataSource = self
        
        topicCollectionView.register(TopicCollectionViewCell.self, forCellWithReuseIdentifier: TopicCollectionViewCell.identifier)
        topicCollectionView.collectionViewLayout = configureCollectionViewLayout()
    }
    
    private func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let spacing: CGFloat = 10
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 200, height: 250)
        return layout
    }
    
}

// MARK: - Extension
extension TopicCustomView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topicData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.identifier, for: indexPath) as! TopicCollectionViewCell
        
        cell.configureData(data: topicData[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItemData(data: topicData[indexPath.item])
    }
    
}
