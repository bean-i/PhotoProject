//
//  PhotoSearchViewController.swift
//  PhotoProject
//
//  Created by 이빈 on 1/17/25.
//

import UIKit

// 검색 파라미터
struct queryParameter: Encodable {
    var query: String = ""
    var page: Int = 1
    var per_page: Int = 20
    var order_by: String = "relevant"
}

final class PhotoSearchViewController: BaseViewController {
    
    private var mainView = PhotoSearchView()
    
    private var params = queryParameter() // 검색 파라미터
    private var photos: [Photo] = [] // 검색 데이터를 담을 배열
    private var total: Int = 0

    override func loadView() {
        view = mainView
    }
    
    override func configureView() {
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        title = "SEARCH PHOTO"
        mainView.sortSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
    }
    
    override func configureDelegate() {
        mainView.searchBar.delegate = self
        
        mainView.photoSearchCollectionView.delegate = self
        mainView.photoSearchCollectionView.dataSource = self
        mainView.photoSearchCollectionView.register(PhotoSearchCollectionViewCell.self, forCellWithReuseIdentifier: PhotoSearchCollectionViewCell.identifier)
        mainView.photoSearchCollectionView.prefetchDataSource = self
    }
    
    @objc private func switchChanged() {
        // 최신순으로 정렬
        if mainView.sortSwitch.isOn {
            initData(orderBy: "latest")
            
            PhotoNetworkManager.shared.getPhotoData(api: .photoSearch, type: PhotoSearchData.self, params: params) { value in
                self.reloadData(value: value)
            } failHandler: { statusCode in
                self.mainView.photoSearchCollectionView.isHidden = true
                self.showAlert(
                    title: statusCode.title,
                    message: statusCode.description,
                    cancel: false) {
                        print("alert")
                    }
            }
        } else {
            initData()
            
            PhotoNetworkManager.shared.getPhotoData(api: .photoSearch, type: PhotoSearchData.self, params: params) { value in
                self.reloadData(value: value)
            } failHandler: { statusCode in
                self.mainView.photoSearchCollectionView.isHidden = true
                self.showAlert(
                    title: statusCode.title,
                    message: statusCode.description,
                    cancel: false) {
                        print("alert")
                    }
            }
        }
    }
    
    // 초기화
    private func initData(orderBy: String = "relevant") {
        params.page = 1
        params.order_by = orderBy
        photos = []
    }

    // 통신 성공 -> 데이터 업데이트
    private func reloadData(value: PhotoSearchData) {
        total = value.total
        if total == 0 {
            self.mainView.photoSearchCollectionView.isHidden = true
            self.mainView.mainLabel.text = "검색 결과가 없어요"
            return
        }
        // 컬렉션뷰 보이게 설정
        self.mainView.photoSearchCollectionView.isHidden = false
        
        self.photos.append(contentsOf: value.results)
    
        self.mainView.photoSearchCollectionView.reloadData()
        
        if params.page == 1 {
            self.mainView.photoSearchCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
        }
    }
}
// MARK: - Extension - UISearchBar
extension PhotoSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            print("searchBar 오류")
            return
        }
        view.endEditing(true)
        
        params.query = searchText
        initData()
        
        // 검색 키워드로 통신
        // 통신 완료되면 테이블뷰 리로드
        
        PhotoNetworkManager.shared.getPhotoData(api: .photoSearch,
                                                type: PhotoSearchData.self,
                                                params: params) { value in
            self.reloadData(value: value)
        } failHandler: { statusCode in
            self.showAlert(
                title: statusCode.title,
                message: statusCode.description,
                cancel: false) {
                    print("alert")
                }
        }
    }
}

// MARK: - Extension - UICollectionView
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
        let vc = PhotoDetailViewController()
        vc.viewModel.output.photoURL.value = photos[indexPath.item].urls.originalURL
        vc.viewModel.input.photoID.value = photos[indexPath.item].id
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Extension - Prefetch
extension PhotoSearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if indexPath.item == photos.count - 2,
               photos.count + params.per_page < total {
                params.page += 1
                
                PhotoNetworkManager.shared.getPhotoData(api: .photoSearch, type: PhotoSearchData.self, params: params) { value in
                    self.reloadData(value: value)
                } failHandler: { statusCode in
                    self.mainView.photoSearchCollectionView.isHidden = true
                    self.showAlert(
                        title: statusCode.title,
                        message: statusCode.description,
                        cancel: false) {
                            print("alert")
                        }
                }
            }
        }
    }
}
