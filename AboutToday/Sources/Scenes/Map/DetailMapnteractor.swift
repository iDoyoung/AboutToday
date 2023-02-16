//
//  DetailMapInteractor.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/16.
//

import Foundation
import Photos

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
        var locations = [CLLocation]()
        guard let assets else { return }
        assets.enumerateObjects { asset, index, _ in
            if let location = asset.location {
                locations.append(location)
            }
        }
        let response = PhotosLocation.Loaded.Response(locations: locations)
        
    }
}
