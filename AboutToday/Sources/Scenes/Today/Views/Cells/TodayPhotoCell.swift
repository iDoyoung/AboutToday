//
//  TodayPhotoCell.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/13.
//

import UIKit
import PinLayout

final class TodayPhotoCell: UICollectionViewCell {
    
    static let reuseIdentifier = "today-photo-cell-reuse-identifier"
    let photoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(photoImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.pin.all()
    }
}
