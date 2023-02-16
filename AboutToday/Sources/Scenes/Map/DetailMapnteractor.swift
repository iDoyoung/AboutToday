//
//  DetailMapInteractor.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/16.
//

import Foundation
import CoreLocation

protocol DetailMapBusinessLogic {
    func loadPhotoLocations()
}

protocol DetailMapDataStore {
    var locations: [CLLocation] { get }
}

final class DetailMapInteractor: DetailMapBusinessLogic, DetailMapDataStore {
    
    var presenter: DetailMapPresenting?
    var locations: [CLLocation] = []
    
    func loadPhotoLocations() {
    }
}
