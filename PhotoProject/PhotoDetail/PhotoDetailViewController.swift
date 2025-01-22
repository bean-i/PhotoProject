//
//  PhotoDetailViewController.swift
//  PhotoProject
//
//  Created by 이빈 on 1/18/25.
//

import UIKit
import Kingfisher

final class PhotoDetailViewController: BaseViewController {
    
    private var mainView = PhotoDetailView()
    var photoURL: String = ""
    var photoId: String = ""
    
    override func loadView() {
        view = mainView
        view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        getData()
    }
    
    override func configureView() {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func getData() {
        
        PhotoNetworkManager.shared.getPhotoData(api: .photoStatistics(id: photoId), type: PhotoDetailData.self) { value in
            self.configureData(value: value)
        } failHandler: { statusCode in
            self.showAlert(
                title: statusCode.title,
                message: statusCode.description,
                cancel: false) {
                    print("alert")
                }
        }
    }
    
    private func configureData(value: PhotoDetailData) {
        let current = self.mainView
        
        current.photoImageView.kf.setImage(with: URL(string: photoURL), placeholder: UIImage(systemName: "square.and.arrow.down"))
        current.viewCountLabel.text = NumberFormatter.decimal(value.views.total as NSNumber)
        current.downCountLabel.text = NumberFormatter.decimal(value.downloads.total as NSNumber)
    }
    
}
