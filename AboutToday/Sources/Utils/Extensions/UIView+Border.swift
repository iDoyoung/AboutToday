//
//  UIView+Border.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/08.
//

import UIKit

extension UIView {
    
    var borderWidth: CGFloat {
        get { layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set { layer.borderColor = newValue?.cgColor }
    }
}
