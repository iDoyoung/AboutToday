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
   
    let currentLocationMapView: CurrentLocationMapView = {
        let mapView = CurrentLocationMapView()
        return mapView
    }()
    
    var photoCollectionView: UICollectionView!
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .systemIndigo
        ///configure collection view
        photoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
        photoCollectionView.isScrollEnabled = false
        ///hierarchy
        addSubview(rootFlexContainer)
        rootFlexContainer.flex
            .padding(20)
            .direction(.column)
            .define { flex in
                ///First Row
                flex.addItem()
                    .marginBottom(10)
                    .height(30%)
                    .direction(.row)
                    .define { flex in
                        ///Setup Today Weather
                        flex.addItem(todayWeatherView)
                            .grow(1)
                            .marginRight(10)
                            .backgroundColor(.systemBackground)
                            .define { flex in
                                flex.view?.cornerRadius = 16
                            }
                        ///Setup Current Location View
                        flex.addItem(currentLocationMapView)
                            .grow(1)
                            .backgroundColor(.systemBackground)
                            .define { flex in
                                flex.view?.cornerRadius = 16
                                flex.view?.layer.masksToBounds = true
                            }
                    }
                //TODO: - Set Second row
                flex.addItem(photoCollectionView)
                    .backgroundColor(.systemBackground)
                    .grow(1)
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

//MARK: - Collection View
extension TodayView {
    ///Create Layout
    private func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
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
