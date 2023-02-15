//
//  WeatherDetail.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/14.
//

import UIKit
import FlexLayout
import PinLayout

final class WeatherDetailView: UIView {
    
    private let rootFlexContainer = UIView()
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    let currentTempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        let font: UIFont = .monospacedDigitSystemFont(ofSize: 100, weight: .light)
        label.font = UIFontMetrics(forTextStyle: .largeTitle).scaledFont(for: font)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()
    
    let maxTempLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()
    
    let minTempLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()
    
    private let fellsLikeImage: UIImageView = {
        let image = UIImage(systemName: "thermometer.medium")
        let imageView = UIImageView(image: image)
        imageView.tintColor = .systemPink
        return imageView
    }()
    
    private let feelsLikeTitle: UILabel = {
        let label = UILabel()
        label.text = "FEELS LIKE"
        label.textColor = .systemPink
        label.font = .preferredFont(forTextStyle: .caption2)
        return label
    }()
    
    let feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private let pressureImage: UIImageView = {
        let image = UIImage(systemName: "gauge.medium")
        let imageView = UIImageView(image: image)
        imageView.tintColor = .systemBlue
        return imageView
    }()
    
    private let pressureTitle: UILabel = {
        let label = UILabel()
        label.text = "PRESSURE"
        label.textColor = .systemBlue
        label.font = .preferredFont(forTextStyle: .caption2)
        return label
    }()
    
    let pressureLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private let humidityImage: UIImageView = {
        let image = UIImage(systemName: "humidity")
        let imageView = UIImageView(image: image)
        imageView.tintColor = .systemMint
        return imageView
    }()
    
    private let humidityTitle: UILabel = {
        let label = UILabel()
        label.text = "HUMIDITY"
        label.textColor = .systemMint
        label.font = .preferredFont(forTextStyle: .caption2)
        return label
    }()
    
    let humidityLabel: UILabel = {
        let label = UILabel()
        label.tintColor = .systemMint
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .systemIndigo
        
        addSubview(rootFlexContainer)
        rootFlexContainer.flex
            .direction(.column)
            .alignItems(.center)
            .define { flex in
                flex.addItem(cityLabel)
                    .marginTop(40)
                flex.addItem(currentTempLabel)
                flex.addItem(descriptionLabel)
                flex.addItem().direction(.row)
                    .marginBottom(40)
                    .define { flex in
                        flex.addItem(maxTempLabel).marginRight(4)
                        flex.addItem(minTempLabel)
                    }
                ///Feels like
                flex.addItem()
                    .marginBottom(5)
                    .padding(10)
                    .width(100%)
                    .backgroundColor(.systemBackground)
                    .direction(.column)
                    .define { flex in
                        flex.addItem()
                            .direction(.row)
                            .define { flex in
                                flex.addItem(fellsLikeImage)
                                    .marginRight(5)
                                flex.addItem(feelsLikeTitle)
                            }
                        flex.addItem(feelsLikeLabel)
                            .marginVertical(5)
                    }
                    
                ///Humidity
                flex.addItem()
                    .marginBottom(5)
                    .padding(10)
                    .width(100%)
                    .backgroundColor(.systemBackground)
                    .direction(.column)
                    .define { flex in
                        flex.addItem()
                            .direction(.row)
                            .define { flex in
                                flex.addItem(humidityImage)
                                    .marginRight(5)
                                flex.addItem(humidityTitle)
                            }
                        flex.addItem(humidityLabel)
                            .marginVertical(5)
                    }
                ///Pressure
                flex.addItem()
                    .padding(10)
                    .width(100%)
                    .backgroundColor(.systemBackground)
                    .direction(.column)
                    .define { flex in
                        flex.addItem()
                            .direction(.row)
                            .define { flex in
                                flex.addItem(pressureImage)
                                    .marginRight(5)
                                flex.addItem(pressureTitle)
                            }
                        flex.addItem(pressureLabel)
                            .marginVertical(5)
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
struct WeatherDetailPreview: PreviewProvider {
    
    static var previews: some View {
        UIViewPreview {
            let view = WeatherDetailView()
            view.cityLabel.text = "수원시"
            view.currentTempLabel.text = "4º"
            view.descriptionLabel.text = "대체로 맑음"
            view.maxTempLabel.text = "최고:10º"
            view.minTempLabel.text = "최저:3º"
            view.feelsLikeLabel.text = "3º"
            view.humidityLabel.text = "39%"
            view.pressureLabel.text = "1,022 hPa"
            return view
        }
    }
}
#endif
