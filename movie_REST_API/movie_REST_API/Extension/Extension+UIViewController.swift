//
//  Extension+UIViewController.swift
//  movie_REST_API
//
//  Created by Анастасия Козлова on 28.10.2022.
//

import UIKit

/// Расширение для UIViewController(Alert)
private enum Constant {
    static let okText = "OK"
}

extension UIViewController {
    typealias Closure = (() -> ())?
    func tapOkButton(title: String?, message: String, handler: Closure) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertControllerAction = UIAlertAction(title: Constant.okText, style: .default) { _ in
            handler?()
        }
        alertController.addAction(alertControllerAction)
        present(alertController, animated: true)
    }
}
