//
//  TopicCollectionViewCell.swift
//  PhotoProject
//
//  Created by 이빈 on 1/18/25.
//

import UIKit
import Kingfisher
import SnapKit

class TopicCollectionViewCell: BaseCollectionViewCell {
    
    static let identifier = "TopicCollectionViewCell"
    
    let photoImageView = UIImageView()
    
    let starButton = StarButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        contentView.addSubViews(photoImageView, starButton)
    }
    
    override func configureLayout() {
        photoImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.size.equalTo(contentView.snp.size)
        }
        
        starButton.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(10)
        }
    }
    
    override func configureView() {
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.tintColor = .black
        photoImageView.layer.cornerRadius = 15
        photoImageView.clipsToBounds = true
    }
    
    func configureData(data: Photo) {
        photoImageView.kf.setImage(with: URL(string: data.urls.thumb), placeholder: UIImage(systemName: "square.and.arrow.down"))
        
        starButton.setTitle(NumberFormatter.decimal(data.likes as NSNumber), for: .normal)
    }
    
}
