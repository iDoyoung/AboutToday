//
//  ListPhotoImages.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/13.
//

import UIKit
import Photos

enum PhotoImage {

    enum Fetched {
        
        struct Reqeuest {
            let asset: PHAsset
            let size: CGSize
            let contentMode: PHImageContentMode
        }
        
        struct Response {
            let image: UIImage
        }
        
        struct ViewModel {
            let images: [UIImage]
        }
    }
}
