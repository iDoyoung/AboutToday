//
//  UIVIew+Corner Radius.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/08.
//

import UIKit

extension UIView {
    
    var cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
}
