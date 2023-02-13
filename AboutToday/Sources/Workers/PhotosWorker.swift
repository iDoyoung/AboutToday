//
//  PhotosWorker.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/13.
//

import Foundation
import Photos

final class PhotosWorker {
    
    private let photosRepoistory: PhotosRepository
    
    init(photosRepoistory: PhotosRepository) {
        self.photosRepoistory = photosRepoistory
    }
    
    func getTodaysPhotos() -> PHFetchResult<PHAsset> {
        return photosRepoistory.fethchPhotosOfToday()
    }
}
