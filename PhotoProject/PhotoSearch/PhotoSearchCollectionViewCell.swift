//
//  PhotoSearchCollectionViewCell.swift
//  PhotoProject
//
//  Created by 이빈 on 1/17/25.
//

import UIKit
import Kingfisher
import SnapKit

class PhotoSearchCollectionViewCell: BaseCollectionViewCell {
    
    static let identifier = "PhotoSearchCollectionViewCell"
    
    let photoImageView = UIImageView()
    
    let starView = UIView()
    let starImageView = UIImageView()
    let starCountLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        starView.addSubViews(starImageView, starCountLabel)
        contentView.addSubViews(photoImageView, starView)
    }
    
    override func configureLayout() {
        photoImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.size.equalTo(contentView.snp.size)
        }
        
        starView.snp.makeConstraints { make in
            make.width.equalTo(75)
            make.height.equalTo(25)
            make.leading.bottom.equalToSuperview().inset(10)
        }
        
        starImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.size.equalTo(15)
        }
        
        starCountLabel.snp.makeConstraints { make in
            make.leading.equalTo(starImageView.snp.trailing).offset(5)
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
    }
    
    override func configureView() {
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.tintColor = .black
        photoImageView.clipsToBounds = true // 이거 왜?!?!?해야하는거죠...
        
        starView.backgroundColor = .darkGray
        starView.layer.cornerRadius = 10
        
        starImageView.image = UIImage(systemName: "star.fill")
        starImageView.tintColor = .yellow
        
        starCountLabel.textColor = .white
        starCountLabel.font = .systemFont(ofSize: 10)
    }
    
    func configureData(data: Photo) {
        let url = URL(string: data.urls.originalURL)
        photoImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "square.and.arrow.down"))
        
        starCountLabel.text = NumberFormatter.decimal(data.likes as NSNumber)
        
    }
    
}
