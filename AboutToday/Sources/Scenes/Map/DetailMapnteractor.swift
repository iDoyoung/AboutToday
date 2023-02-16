//
//  DetailMapInteractor.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/16.
//

import Foundation
import Photos
import CoreLocation

protocol DetailMapBusinessLogic {
    func loadPhotoLocations()
}

protocol DetailMapDataStore {
    var assets: PHFetchResult<PHAsset>? { get set }
}

final class DetailMapInteractor: DetailMapBusinessLogic, DetailMapDataStore {
    
    var presenter: DetailMapPresenting?
    var assets: PHFetchResult<PHAsset>?
    
    func loadPhotoLocations() {
    }
}
