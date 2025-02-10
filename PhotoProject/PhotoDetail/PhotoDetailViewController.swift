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
    
    deinit {
        print("PhotoDetailViewController Deinit")
    }
    
    override func bindData() {
        viewModel.output.viewDidLoadTrigger.lazyBind { [weak self] _ in
            self?.view.backgroundColor = .white
            self?.navigationController?.navigationBar.isHidden = false
            self?.navigationController?.navigationBar.prefersLargeTitles = false
        }
        
        viewModel.output.configureUserData.bind { [weak self] data in
            
            guard let data else {
                print("데이터 오류")
                return
            }
            
            if let url = URL(string: data.user.profile_image.medium) {
                self?.mainView.profileImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "square.and.arrow.down"))
            }
            
            self?.mainView.nameLabel.text = data.user.name

            let date = DateFormatter.isoFormat(data.created_at)!
            self?.mainView.dateLabel.text = "\(DateFormatter.stringFromDate(date)) 게시됨"
        }
        
        // lazyBind로 하면 안 됨.
        // 이미 viewDidLoad시점에 최종 데이터가 들어가 있음.
        // 여기서 lazyBind는 뷰디드로드 하고 나서 바뀌는 값에 대해서만 클로저가 실행 됨.
        viewModel.output.photoURL.bind { [weak self] data in
            print("photoURL")
            if let url = URL(string: data) {
                self?.mainView.photoImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "square.and.arrow.down"))
            } else {
                self?.mainView.photoImageView.backgroundColor = .black
            }
        }
        
        viewModel.output.configurePhotoData.bind { [weak self] data in
            guard let data else {
                print("데이터가 nil")
                return
            }
            
            self?.mainView.viewCountLabel.text = NumberFormatter.decimal(data.views.total as NSNumber)
            self?.mainView.downCountLabel.text = NumberFormatter.decimal(data.downloads.total as NSNumber)
        }
        
        viewModel.output.configureError.bind { [weak self] statusCode in
            guard let statusCode else {
                print("오류 nil")
                return
            }
            
            self?.showAlert(
                title: statusCode.title,
                message: statusCode.description,
                cancel: false) {
                    print("alert")
                }
        }
    }
}
