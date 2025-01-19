//
//  PhotoDetailViewController.swift
//  PhotoProject
//
//  Created by 이빈 on 1/18/25.
//

import UIKit
import Kingfisher

class PhotoDetailViewController: BaseViewController {
    
    var mainView = PhotoDetailView()
    var photoURL: String = ""
    var photoId: String = ""
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    override func configureView() {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func getData() {
        NetworkManager.shared.getPhotoStatisticsData(imageId: photoId) { value in
            self.configureData(value: value)
        }
    }
    
    func configureData(value: PhotoDetailData) {
        let current = self.mainView
        
        current.photoImageView.kf.setImage(with: URL(string: photoURL), placeholder: UIImage(systemName: "square.and.arrow.down"))
        current.viewCountLabel.text = NumberFormatter.decimal(value.views.total as NSNumber)
        current.downCountLabel.text = NumberFormatter.decimal(value.downloads.total as NSNumber)
    }
    
}
