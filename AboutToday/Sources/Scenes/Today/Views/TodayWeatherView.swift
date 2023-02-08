//
//  TodayWeatherView.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/08.
//

import UIKit
import FlexLayout
import PinLayout

final class TodayWeatherView: UIView {
    
    private let rootFlexContainer = UIView()
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()
    
    let currentTempLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    let maxTempLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        return label
    }()
    
    let minTempLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .setGradientEffect(colors: [.systemBackground, .systemGray],
                                          frame: bounds,
                                          startPoint: CGPoint(x: 0, y: 0),
                                          endPoint: CGPoint(x: 1, y: 1))
        borderColor = .secondarySystemBackground
        borderWidth = 1
        cornerRadius = 16
        
        addSubview(rootFlexContainer)
        rootFlexContainer.flex
            .direction(.column)
            .justifyContent(.center)
            .padding(16)
            .define { flex in
                flex.addItem(cityLabel)
                flex.addItem(currentTempLabel)
                flex.addItem()
                    .marginTop(20)
                    .direction(.row)
                    .define { flex in
                        flex.addItem(maxTempLabel)
                        flex.addItem(minTempLabel)
                    }
            }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rootFlexContainer.pin.all(self.pin.safeArea)
        rootFlexContainer.flex.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct TodayWeatherViewPreview: PreviewProvider {
    
    static var previews: some View {
        UIViewPreview {
            let view = TodayWeatherView()
            view.cityLabel.text = "New York"
            view.currentTempLabel.text = "10º"
            view.maxTempLabel.text = "12º"
            view.minTempLabel.text = "0º"
            return view
        }
    }
}
#endif
