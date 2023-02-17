//
//  DetailMapPresenter.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/16.
//

import UIKit
import MapKit

protocol DetailMapPresenting {
    func presentPhotosLocations(response: PhotosLocation.Loaded.Response)
}

final class DetailMapPresenter: DetailMapPresenting {
    
    weak var viewController: DetailMapDisplayLogic?
    
    func presentPhotosLocations(response: PhotosLocation.Loaded.Response) {
        let annotations = response.locations
            .map {
                CLLocationCoordinate2D(latitude: $0.coordinate.latitude,
                                       longitude: $0.coordinate.longitude)
            }
            .map {
                PhotoAnnotation(coordinate: $0)
            }
        let viewModel = PhotosLocation.Loaded.ViewModel(annotations: annotations)
        viewController?.displayAnnotationOfLocation(viewModel: viewModel)
    }
}
