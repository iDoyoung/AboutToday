//
//  PhotosLocation.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/16.
//

import Foundation
import CoreLocation
import MapKit

struct PhotosLocation {
    enum Loaded {
        
        struct Response {
            let locations: [CLLocation]
        }
        
        struct ViewModel {
            let annotations: [MKAnnotation]
        }
    }
}
