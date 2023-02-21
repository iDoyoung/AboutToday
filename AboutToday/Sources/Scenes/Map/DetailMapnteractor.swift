//
//  DetailMapInteractor.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/16.
//

import Foundation
import CoreLocation
import Photos

protocol DetailMapBusinessLogic {
    func loadPhotoLocations()
    func loadCurrentLocation()
}

protocol DetailMapDataStore {
    var currentLocation: CLLocation? { get set }
    var assets: PHFetchResult<PHAsset>? { get set }
}

final class DetailMapInteractor: DetailMapBusinessLogic, DetailMapDataStore {
    
    var presenter: DetailMapPresenting?
    //MARK: Data Store
    var assets: PHFetchResult<PHAsset>?
    var currentLocation: CLLocation?
    
    func loadCurrentLocation() {
        guard let currentLocation else { return }
        presenter?.presentCurrentLocation(currentLocation)
    }
    
    func loadPhotoLocations() {
        var locations = [CLLocation]()
        guard let assets else { return }
        assets.enumerateObjects { asset, index, _ in
            if let location = asset.location {
                locations.append(location)
            }
        }
        let response = PhotosLocation.Loaded.Response(locations: locations)
        presenter?.presentPhotosLocations(response: response)
    }
}
