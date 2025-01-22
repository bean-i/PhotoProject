//
//  StarButton.swift
//  PhotoProject
//
//  Created by 이빈 on 1/19/25.
//

import UIKit

final class StarButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureButton() {
        var config = UIButton.Configuration.filled()
        config.buttonSize = .small
        config.cornerStyle = .capsule
        config.baseBackgroundColor = .darkGray
        config.baseForegroundColor = .white
        config.image = UIImage(systemName: "star.fill")?.withTintColor(.yellow, renderingMode: .alwaysOriginal)
        config.imagePadding = 8
        self.configuration = config
    }
    
}
