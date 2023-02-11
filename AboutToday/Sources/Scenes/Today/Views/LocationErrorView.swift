//
//  LocationErrorView.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/10.
//

import UIKit
import FlexLayout
import PinLayout

final class LocationErrorView: UIView {
    
    private let rootFlexContainer = UIView()
    
    let image: UIImageView = {
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .default)
        let image = UIImage(systemName: "exclamationmark.octagon", withConfiguration: imageConfiguration)
        let imageView = UIImageView(image: image)
        imageView.tintColor = .systemRed
        return imageView
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .headline)
        label.text = "Location Error"
        return label
    }()
    
    let message: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .caption1)
        label.text = "Location unavailable. Enable location services in the Settings app."
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        
        addSubview(rootFlexContainer)
        rootFlexContainer.flex
            .padding(10)
            .direction(.column)
            .alignItems(.center)
            .justifyContent(.center)
            .define { flex in
                flex.addItem(image)
                flex.addItem(title)
                flex.addItem(message)
            }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rootFlexContainer.pin.all()
        rootFlexContainer.flex.layout()
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct LocationErrorPreview: PreviewProvider {
    
    static var previews: some View {
        UIViewPreview {
            return LocationErrorView()
        }
    }
}
#endif
