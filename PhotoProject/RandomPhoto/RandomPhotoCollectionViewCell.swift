//
//  RandomPhotoCollectionViewCell.swift
//  PhotoProject
//
//  Created by 이빈 on 1/21/25.
//

import UIKit
import Kingfisher
import SnapKit

final class RandomPhotoCollectionViewCell: BaseCollectionViewCell {
    
    static let identifier = "RandomPhotoCollectionViewCell"
    
    private let imageView = UIImageView()
    
    private let countView = UIView()
    private let countLabel = UILabel()
    
    private let infoView = UIView()
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let dateLabel = UILabel()
    private let heartButton = UIButton()
    
    override func configureHierarchy() {
        countView.addSubview(countLabel)
        infoView.addSubViews(profileImageView, nameLabel, dateLabel, heartButton)
        addSubViews(imageView, countView, infoView)
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        countView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(70)
            make.trailing.equalToSuperview().inset(30)
            make.width.equalTo(60)
            make.height.equalTo(25)
        }
        
        countLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        infoView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(80)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
            make.size.equalTo(40)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(3)
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
        }
        
        heartButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
        }
        
    }
    
    override func configureView() {
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .black
        
        countView.backgroundColor = .darkGray
        countView.layer.cornerRadius = 12
        
        countLabel.textColor = .white
        countLabel.textAlignment = .center
        countLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        
        infoView.backgroundColor = .clear
        
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 20
        profileImageView.contentMode = .scaleAspectFill
        
        nameLabel.textColor = .white
        nameLabel.font = .systemFont(ofSize: 14)
        nameLabel.textAlignment = .left
        
        dateLabel.textColor = .white
        dateLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        dateLabel.textAlignment = .left
        
        heartButton.backgroundColor = .clear
        heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        heartButton.tintColor = .white
    }
    
    func configureData(data: RandomPhotoData, index: Int) {
        
        imageView.kf.setImage(with: URL(string: data.urls.originalURL), placeholder: UIImage(systemName: "square.and.arrow.down"))
        
        profileImageView.kf.setImage(with: URL(string: data.user.profile_image.medium), placeholder: UIImage(systemName: "square.and.arrow.down"))
        
        nameLabel.text = data.user.name
        countLabel.text = "\(index + 1) / 10"

        let date = DateFormatter.isoFormat(data.created_at)!
        dateLabel.text = "\(DateFormatter.stringFromDate(date)) 게시됨"
    }
    
}
