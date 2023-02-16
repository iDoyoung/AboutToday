//
//  PhotoAnnotation.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/16.
//

import MapKit

final class PhotoAnnotation: NSObject, MKAnnotation {
    
    static let reuseIdentifier = "photo-annotation-reuse-identifier"
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        super.init()
    }
}
