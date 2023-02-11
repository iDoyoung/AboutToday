//
//  CurrentLocationView.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/10.
//

import UIKit
import MapKit
import PinLayout

final class CurrentLocationMapView: UIView {
    
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        return mapView
    }()
    
    let errorView: LocationErrorView = {
        let view = LocationErrorView()
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        addSubview(mapView)
        addSubview(errorView)
        toggleMapVisibility(hide: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mapView.pin.top().left().right().bottom()
        errorView.pin.top().left().right().bottom()
    }
    
    func toggleMapVisibility(hide: Bool) {
        mapView.isHidden = isHidden
        errorView.isHidden = !isHidden
    }
}
