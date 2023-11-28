//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Onurcan Sever on 2023-11-27.
//

import UIKit

extension UIViewController {
    
    // We have to present our alert view controller from main thread, not background thread.
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve // Fade in animation.
            self.present(alertVC, animated: true)
        }
    }
    
}
