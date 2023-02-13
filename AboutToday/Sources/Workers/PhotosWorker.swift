//
//  PhotosWorker.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/13.
//

import Foundation
import Photos

final class PhotosWorker {
    
    private let photosRepository: PhotosRepository
    
    init(photosRepository: PhotosRepository) {
        self.photosRepository = photosRepository
    }
    
    func getTodaysPhotos() -> PHFetchResult<PHAsset> {
        return photosRepository.fetchPhotosOfToday()
    }
}
