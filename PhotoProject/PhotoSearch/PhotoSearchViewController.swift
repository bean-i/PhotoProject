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
    
    let sortLabel = UILabel()
    let sortSwitch = UISwitch()
    
    let mainLabel = UILabel()
    let photoSearchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    var params = Parameters()
    // 검색 데이터를 담을 배열
    var photos: [Photo] = []
    var total: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SEARCH PHOTO"
        photoSearchCollectionView.isHidden = true
    }
    
    override func configureHierarchy() {
        
        [
            searchBar,
            sortLabel,
            sortSwitch,
            mainLabel,
            photoSearchCollectionView
        ].forEach { view.addSubview($0) }

    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
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
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    override func configureView() {
        searchBar.placeholder = "키워드 검색"
        
        sortLabel.text = "최신순"
        
        sortSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        
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
    
    @objc func switchChanged() {
        // 최신순으로 정렬
        params.order_by = "latest"
        params.page = 1
        NetworkManager.shared.getPhotoSearchData(params: params) { value in
            self.reloadData(value: value)
        }
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
        total = value.total
        if total == 0 {
            self.photoSearchCollectionView.isHidden = true
            self.mainLabel.text = "검색 결과가 없어요"
            return
        }
        // 컬렉션뷰 보이게 설정
        self.photoSearchCollectionView.isHidden = false
        
        if params.page == 1 {
            self.photos = value.results
        } else {
            self.photos.append(contentsOf: value.results)
        }
        
        self.photoSearchCollectionView.reloadData()
        
        if params.page == 1 {
            self.photoSearchCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
        }
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
        params.page = 1
        
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
            if indexPath.item == photos.count - 2,
               photos.count + params.per_page < total {
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function, indexPath)
        let vc = PhotoDetailViewController()
        vc.photoURL = photos[indexPath.item].urls.originalURL
        vc.photoId = photos[indexPath.item].id
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
