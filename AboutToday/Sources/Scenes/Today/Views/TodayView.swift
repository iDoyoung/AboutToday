//
//  TodayView.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/07.
//

import UIKit
import FlexLayout
import PinLayout

final class TodayView: UIView {
    
    private let rootFlexContainer = UIView()

    let todayWeatherView = TodayWeatherView()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        
        addSubview(rootFlexContainer)
        rootFlexContainer.flex
            .direction(.column)
            .padding(0)
            .define { flex in
                ///First Row Containter
                flex.addItem()
                    .direction(.row)
                    .define { flex in
                        flex.addItem(todayWeatherView)
                    }
            }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rootFlexContainer.pin.all(self.pin.safeArea)
        rootFlexContainer.flex.layout()
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct TodayPreview: PreviewProvider {
    
    static var previews: some View {
        UIViewPreview {
            let view = TodayView()
            view.todayWeatherView.cityLabel.text = "New york city"
            view.todayWeatherView.currentTempLabel.text = "10º"
            view.todayWeatherView.maxTempLabel.text = "12º"
            view.todayWeatherView.minTempLabel.text = "0º"
            return view
        }
    }
}
#endif
