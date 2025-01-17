//
//  PhotoSearchViewController.swift
//  PhotoProject
//
//  Created by 이빈 on 1/17/25.
//

import UIKit
import SnapKit
import Alamofire

struct Parameters {
    var query: String = ""
    var page: Int = 1
    var per_page: Int = 20
    var order_by: String = "relevant"
    let client_id: String = SearchPhotoAPI.clientID
}

class PhotoSearchViewController: BaseViewController {
    
    let searchBar = UISearchBar()
    let mainLabel = UILabel()
    let photoSearchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    var params = Parameters()
    // 검색 데이터를 담을 배열
    var photos: [Photo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SEARCH PHOTO"
    }
    
    override func configureHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(mainLabel)
        view.addSubview(photoSearchCollectionView)
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        photoSearchCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    override func configureView() {
        searchBar.placeholder = "키워드 검색"
        
        mainLabel.text = "사진을 검색해보세요."
        mainLabel.font = .systemFont(ofSize: 16, weight: .bold)
    }
    
    override func configureDelegate() {
        searchBar.delegate = self
        
        photoSearchCollectionView.delegate = self
        photoSearchCollectionView.dataSource = self
        photoSearchCollectionView.register(PhotoSearchCollectionViewCell.self, forCellWithReuseIdentifier: PhotoSearchCollectionViewCell.identifier)
        photoSearchCollectionView.collectionViewLayout = configureCollectionVeiwLayout()
        photoSearchCollectionView.prefetchDataSource = self
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
    
    // 통신 성공 -> 데이터 업데이트
    func reloadData(value: PhotoSearchData) {
        
        if params.page == 1 {
            self.photos = value.results
        } else {
            self.photos.append(contentsOf: value.results)
        }
        
        self.photoSearchCollectionView.reloadData()
    }
    
    // 새로운 파라미터로 데이터 초기화
    func updateDataWithParams() {
        
    }

}

extension PhotoSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        
        guard let searchText = searchBar.text else {
            print("searchBar 오류")
            return
        }
        params.query = searchText
        
        // 검색 키워드로 통신
        // 통신 완료되면 테이블뷰 리로드
        NetworkManager.shared.getPhotoSearchData(params: params) { value in
            self.reloadData(value: value)
        }
    }
}

extension PhotoSearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print(#function, indexPaths)
        for indexPath in indexPaths {
            if indexPath.item == photos.count - 2 {
                print("업데이트!")
                params.page += 1
                NetworkManager.shared.getPhotoSearchData(params: params) { value in
                    self.reloadData(value: value)
                }
            }
        }
    }
    
    
}

extension PhotoSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoSearchCollectionViewCell.identifier, for: indexPath) as! PhotoSearchCollectionViewCell
        cell.configureData(data: photos[indexPath.item])
        return cell
    }
    
    
}
