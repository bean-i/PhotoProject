//
//  PhotoDetailView.swift
//  PhotoProject
//
//  Created by 이빈 on 1/19/25.
//

import UIKit
import SnapKit

final class PhotoDetailView: BaseView {
    
    let photoImageView = UIImageView()
    
    private let infoLabel = UILabel()
    
    private let viewStackView = UIStackView()
    private let viewLabel = UILabel()
    let viewCountLabel = UILabel()
    
    private let downStackView = UIStackView()
    private let downLabel = UILabel()
    let downCountLabel = UILabel()
    
    override func configureHierarchy() {
        viewStackView.addArrangedSubviews(viewLabel, viewCountLabel)
        downStackView.addArrangedSubviews(downLabel, downCountLabel)
        
        addSubViews(
            photoImageView,
            infoLabel,
            viewStackView,
            downStackView
        )
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
