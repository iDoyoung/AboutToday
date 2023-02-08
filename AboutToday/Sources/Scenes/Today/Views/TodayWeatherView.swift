//
//  TodayWeatherView.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/08.
//

import UIKit
import PinLayout

final class TodayWeatherView: UIView {
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()
    
    let currentTempLabel: UILabel = {
        let label = UILabel()
        label.text = "-º"
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    let maxTempLabel: UILabel = {
        let label = UILabel()
        label.text = "-º"
        label.font = .preferredFont(forTextStyle: .caption1)
        return label
    }()
    
    let minTempLabel: UILabel = {
        let label = UILabel()
        label.text = "-º"
        label.font = .preferredFont(forTextStyle: .caption1)
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        addSubview(cityLabel)
        addSubview(currentTempLabel)
        addSubview(maxTempLabel)
        addSubview(minTempLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cityLabel.pin
            .top()
            .left()
            .right()
            .sizeToFit(.width)
        currentTempLabel.pin
            .below(of: cityLabel, aligned: .start)
            .right()
            .sizeToFit(.width)
        maxTempLabel.pin
            .bottom()
            .left()
            .sizeToFit()
        minTempLabel.pin
            .after(of: maxTempLabel, aligned: .bottom)
            .right()
            .sizeToFit()
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
