//
//  PhotosService.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/11.
//

import Foundation
import Photos

protocol PhotosServiceProtocol {
    func fetchPhotosAsset(with options: PHFetchOptions) -> PHFetchResult<PHAsset>
}

final class PhotosService: PhotosServiceProtocol {
    
    func fetchPhotosAsset(with options: PHFetchOptions) -> PHFetchResult<PHAsset> {
        return PHAsset.fetchAssets(with: options)
    }
}
