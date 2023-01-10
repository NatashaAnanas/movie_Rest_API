//
//  UIView+Extension.swift
//  movie_REST_API
//
//  Created by Анастасия Козлова on 09.01.2023.
//

import UIKit

/// Расширение для добавления UIView элементов
public extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
