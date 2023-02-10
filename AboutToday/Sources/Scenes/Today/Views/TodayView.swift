//
//  TodayView.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/07.
//

import UIKit
import MapKit
import FlexLayout
import PinLayout

final class TodayView: UIView {
    
    private let rootFlexContainer = UIView()

    let todayWeatherView = TodayWeatherView()
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        return mapView
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .secondarySystemBackground
        
        addSubview(rootFlexContainer)
        rootFlexContainer.flex
            .padding(20)
            .direction(.column)
            .define { flex in
                ///First Row
                flex.addItem()
                    .height(30%)
                    .direction(.row)
                    .define { flex in
                        ///Setup Today Weather
                        flex.addItem().width(50%).define { flex in
                            flex.backgroundColor(.systemBackground)
                            flex.view?.cornerRadius = 16
                            flex.padding(20)
                            flex.addItem(todayWeatherView).width(100%).height(100%)
                        }
                        //TODO: - Setup Current Location View
                        flex.addItem().width(50%).define { flex in
                            flex.backgroundColor(.systemBackground)
                            flex.view?.cornerRadius = 16
                            flex.view?.layer.masksToBounds = true
                            flex.addItem(mapView).width(100%).height(100%)
                        }
                    }
                //TODO: - Set Second row
                flex.addItem()
                    .backgroundColor(.systemBackground)
                    .height(50%)
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
