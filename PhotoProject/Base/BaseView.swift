//
//  BaseView.swift
//  PhotoProject
//
//  Created by 이빈 on 1/17/25.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() { }
    
    func configureLayout() { }
    
    func configureView() { }
    
}
