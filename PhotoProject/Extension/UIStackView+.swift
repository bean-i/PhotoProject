//
//  UIStackView+.swift
//  PhotoProject
//
//  Created by 이빈 on 1/19/25.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}
