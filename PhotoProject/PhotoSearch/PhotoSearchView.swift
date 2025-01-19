//
//  PhotoSearchView.swift
//  PhotoProject
//
//  Created by 이빈 on 1/19/25.
//

import UIKit
import SnapKit

class PhotoSearchView: BaseView {
    
    let searchBar = UISearchBar()
    
    let sortLabel = UILabel()
    let sortSwitch = UISwitch()
    
    let mainLabel = UILabel()
    let photoSearchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    override func configureHierarchy() {
        
        [
            searchBar,
            sortLabel,
            sortSwitch,
            mainLabel,
            photoSearchCollectionView
        ].forEach { addSubview($0) }

    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        sortLabel.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.trailing.equalTo(sortSwitch.snp.leading).offset(-5)
        }
        
        sortSwitch.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(5)
            make.trailing.equalToSuperview().inset(10)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        photoSearchCollectionView.snp.makeConstraints { make in
            make.top.equalTo(sortSwitch.snp.bottom).offset(5)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        searchBar.placeholder = "키워드 검색"
        sortLabel.text = "최신순"
        mainLabel.text = "사진을 검색해보세요."
        mainLabel.font = .systemFont(ofSize: 16, weight: .bold)
        photoSearchCollectionView.collectionViewLayout = configureCollectionVeiwLayout()
        photoSearchCollectionView.isHidden = true
    }
    
    func configureCollectionVeiwLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let spacing: CGFloat = 5
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = (deviceWidth - (3 * spacing)) / 2
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth + 30)
        
        return layout
    }
    
    
}
