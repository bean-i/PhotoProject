//
//  UIViewController+.swift
//  PhotoProject
//
//  Created by 이빈 on 1/19/25.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, button: String, cancel: Bool, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let button = UIAlertAction(title: button, style: .default) { action in
            completionHandler()
        }
        alert.addAction(button)
        
        if cancel {
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            alert.addAction(cancel)
        }
        self.present(alert, animated: true)
    }
}
