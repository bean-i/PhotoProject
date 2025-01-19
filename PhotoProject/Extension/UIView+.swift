//
//  UIView+.swift
//  PhotoProject
//
//  Created by 이빈 on 1/19/25.
//

import UIKit

extension UIView {
    func addSubViews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
