// UIView+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для добавления UIView элементов
extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
