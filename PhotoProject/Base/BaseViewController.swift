//
//  BaseViewController.swift
//  PhotoProject
//
//  Created by 이빈 on 1/17/25.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        configureDelegate()
    }
    
    func configureHierarchy() { }
    
    func configureLayout() { }
    
    func configureView() { }
    
    func configureDelegate() { }
}
