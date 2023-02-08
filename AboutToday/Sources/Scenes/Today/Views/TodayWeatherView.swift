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
        label.font = .preferredFont(forTextStyle: .caption2)
        return label
    }()
    
    let minTempLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption2)
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        
        addSubview(rootFlexContainer)
        rootFlexContainer.flex
            .direction(.column)
            .define { flex in
                flex.addItem(cityLabel)
                flex.addItem(currentTempLabel)
                flex.addItem()
                    .direction(.row)
                    .define { flex in
                        flex.addItem(maxTempLabel).grow(1)
                        flex.addItem(minTempLabel).grow(1)
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
