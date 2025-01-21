//
//  SecondViewController.swift
//  PhotoProject
//
//  Created by 이빈 on 1/17/25.
//

import UIKit
import Alamofire
import SnapKit

class RandomPhotoViewController: BaseViewController {

    let randomCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    var randomPhotos: [RandomPhotoData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PhotoNetworkManager.shared.getRandomPhotoData(api: .randomPhoto) { value in
            print(value)
            self.randomPhotos = value
            self.randomCollectionView.reloadData()
        }
        
    }
    
    override func configureHierarchy() {
        view.addSubview(randomCollectionView)
    }
    
    override func configureLayout() {
        
        randomCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureView() {
        randomCollectionView.delegate = self
        randomCollectionView.dataSource = self
        randomCollectionView.register(RandomPhotoCollectionViewCell.self, forCellWithReuseIdentifier: RandomPhotoCollectionViewCell.identifier)
        randomCollectionView.collectionViewLayout = configureCollectionViewLayout()
        randomCollectionView.showsVerticalScrollIndicator = false
        randomCollectionView.isPagingEnabled = true
        randomCollectionView.contentInsetAdjustmentBehavior = .never // ...
    }
    
    func configureCollectionViewLayout() -> UICollectionViewLayout {
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
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    }
    
}
