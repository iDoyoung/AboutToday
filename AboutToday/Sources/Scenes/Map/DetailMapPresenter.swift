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
    func presentCurrentLocation(_ location: CLLocation)
}


final class DetailMapPresenter: DetailMapPresenting {
    
    weak var viewController: DetailMapDisplayLogic?
    private let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    
    func presentCurrentLocation(_ location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                                longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        viewController?.displayCurrentLocation(region: region)
    }
    
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
