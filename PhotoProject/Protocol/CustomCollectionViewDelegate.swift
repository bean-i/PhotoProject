//
//  CollectionViewDelegate.swift
//  PhotoProject
//
//  Created by 이빈 on 1/19/25.
//

import Foundation

protocol CustomCollectionViewDelegate: AnyObject {
    func didSelectItemData(data: Photo)
}
