//
//  PhotoDetailView.swift
//  PhotoProject
//
//  Created by 이빈 on 1/19/25.
//

import UIKit
import SnapKit

class PhotoDetailView: BaseView {
    
    let photoImageView = UIImageView()
    
    let infoLabel = UILabel()
    
    let viewStackView = UIStackView()
    let viewLabel = UILabel()
    let viewCountLabel = UILabel()
    
    let downStackView = UIStackView()
    let downLabel = UILabel()
    let downCountLabel = UILabel()
    
    override func configureHierarchy() {
        
        [viewLabel, viewCountLabel].forEach { viewStackView.addArrangedSubview($0) }
        [downLabel, downCountLabel].forEach { downStackView.addArrangedSubview($0) }
        
        [photoImageView, infoLabel, viewStackView, downStackView].forEach { addSubview($0) }
    }
    
    override func configureLayout() {
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(300)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(15)
        }
        
        viewStackView.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(15)
            make.leading.equalTo(infoLabel.snp.trailing).offset(40)
            make.trailing.equalToSuperview().inset(20)
        }
        
        downStackView.snp.makeConstraints { make in
            make.top.equalTo(viewStackView.snp.bottom).offset(10)
            make.leading.equalTo(infoLabel.snp.trailing).offset(40)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    override func configureView() {
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        photoImageView.tintColor = .black
        
        infoLabel.text = "정보"
        infoLabel.font = .systemFont(ofSize: 18, weight: .heavy)
        infoLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        viewStackView.distribution = .fillProportionally
        viewLabel.text = "조회수"
        viewLabel.textAlignment = .left
        viewLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        viewCountLabel.textAlignment = .right
        viewCountLabel.font = .systemFont(ofSize: 16)
        
        downStackView.distribution = .equalSpacing
        downLabel.text = "다운로드"
        downLabel.textAlignment = .left
        downLabel.font = .systemFont(ofSize: 16, weight: .bold)

        downCountLabel.textAlignment = .right
        downCountLabel.font = .systemFont(ofSize: 16)
    }
    
}
