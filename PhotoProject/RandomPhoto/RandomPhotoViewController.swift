//
//  SecondViewController.swift
//  PhotoProject
//
//  Created by 이빈 on 1/17/25.
//

import UIKit
import Alamofire
import SnapKit

final class RandomPhotoViewController: BaseViewController {

    private let randomCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    private var randomPhotos: [RandomPhotoData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        
        PhotoNetworkManager.shared.getPhotoData(api: .randomPhoto, type: [RandomPhotoData].self) { value in
            self.randomPhotos = value
            self.randomCollectionView.reloadData()
        } failHandler: {
            print("통신 실패")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func configureHierarchy() {
        view.addSubview(randomCollectionView)
    }
    
    override func configureLayout() {
        
        randomCollectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height - self.tabBarController!.tabBar.frame.size.height)
        }
    }
    
    override func configureView() {
        randomCollectionView.delegate = self
        randomCollectionView.dataSource = self
        randomCollectionView.register(RandomPhotoCollectionViewCell.self, forCellWithReuseIdentifier: RandomPhotoCollectionViewCell.identifier)
        randomCollectionView.collectionViewLayout = configureCollectionViewLayout()
        randomCollectionView.showsVerticalScrollIndicator = false
        randomCollectionView.isPagingEnabled = true // 테이블뷰의 크기만큼..
        randomCollectionView.contentInsetAdjustmentBehavior = .never // ...
    }
    
    private func configureCollectionViewLayout() -> UICollectionViewLayout {
        print(#function)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = .zero
        let deviceWidth = UIScreen.main.bounds.width
        let deviceHeight = UIScreen.main.bounds.height - self.tabBarController!.tabBar.frame.size.height
        layout.itemSize = CGSize(width: deviceWidth, height: deviceHeight)
        return layout
    }

}

extension RandomPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return randomPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RandomPhotoCollectionViewCell.identifier, for: indexPath) as! RandomPhotoCollectionViewCell
        
        cell.configureData(data: randomPhotos[indexPath.item], index: indexPath.item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        let vc = PhotoDetailViewController()
        vc.photoURL = randomPhotos[indexPath.item].urls.originalURL
        vc.photoId = randomPhotos[indexPath.item].id
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
