//
//  PhotoDetailViewController.swift
//  PhotoProject
//
//  Created by 이빈 on 1/18/25.
//

import UIKit
import Kingfisher

final class PhotoDetailViewController: BaseViewController {
    
    private var mainView = PhotoDetailView()
    let viewModel = PhotoDetailViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.input.viewDidLoadTrigger.value = ()
    }
    
    override func bindData() {
        viewModel.output.viewDidLoadTrigger.lazyBind { [weak self] _ in
            self?.view.backgroundColor = .white
            self?.navigationController?.navigationBar.isHidden = false
            self?.navigationController?.navigationBar.prefersLargeTitles = false
        }
        
        // lazyBind로 하면 안 됨.
        // lazyBind는 뷰디드로드 하고 나서 바뀌는 값에 대해서만 클로저가 실행 됨.
        viewModel.output.photoURL.bind { [weak self] data in
            if let url = URL(string: data) {
                self?.mainView.photoImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "square.and.arrow.down"))
            } else {
                self?.mainView.photoImageView.backgroundColor = .black
            }
        }
        
        viewModel.output.configureData.lazyBind { [weak self] data in
            guard let data else {
                print("데이터가 nil")
                return
            }
            
            self?.mainView.viewCountLabel.text = NumberFormatter.decimal(data.views.total as NSNumber)
            self?.mainView.downCountLabel.text = NumberFormatter.decimal(data.downloads.total as NSNumber)
        }
        
        viewModel.output.configureError.lazyBind { statusCode in
            guard let statusCode else {
                print("오류 nil")
                return
            }
            
            self.showAlert(
                title: statusCode.title,
                message: statusCode.description,
                cancel: false) {
                    print("alert")
                }
        }
    }
}
