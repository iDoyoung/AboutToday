//
//  PhotosRepository.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/12.
//

import Foundation
import Photos

protocol PhotosRepository {
    func fethchPhotosOfToday() -> PHFetchResult<PHAsset>
}

final class DefaultPhotosRepository: PhotosRepository {
    
    private let service: PhotosServiceProtocol
    
    init(service: PhotosServiceProtocol) {
        self.service = service
    }
    
    func fethchPhotosOfToday() -> PHFetchResult<PHAsset> {
        let options = PHFetchOptions()
        let startOfToday = Calendar.current.startOfDay(for: Date())
        options.predicate = NSPredicate(format: "mediaType == %d && !(mediaSubtypes == %d) && creationDate > %@",
                                        PHAssetMediaType.image.rawValue,
                                        PHAssetMediaSubtype.photoScreenshot.rawValue,
                                        startOfToday as NSDate)
        return service.fetchPhotosAsset(with: options)
    }
}
