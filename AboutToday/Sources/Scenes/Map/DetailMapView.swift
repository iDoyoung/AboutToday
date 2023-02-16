//
//  DetailMapView.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/16.
//

import UIKit
import MapKit
import PinLayout

final class DetailMapView: UIView {

    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        return mapView
    }()
    
    init() {
        super.init(frame: .zero)
        addSubview(mapView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mapView.pin.all()
    }
}
