//
//  DetailMapViewController.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/16.
//

import UIKit
import MapKit

protocol DetailMapDisplayLogic: AnyObject {
    func displayAnnotationOfLocation(viewModel: PhotosLocation.Loaded.ViewModel)
}

final class DetailMapViewController: ViewController, DetailMapDisplayLogic {
    
    var interactor: DetailMapBusinessLogic?
    var router: (DetailMapRouting&DetailMapDataPassing)?
    
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        return mapView
    }()
    
    //MARK: - Life Cycle
    override func loadView() {
        view = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerMapAnnotationViews()
        mapView.delegate = self
        interactor?.loadPhotoLocations()
    }
    
    /// - Tag: Register annotation views
    private func registerMapAnnotationViews() {
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: PhotoAnnotation.reuseIdentifier)
    }
    
    //MARK: - Display Logics
    func displayAnnotationOfLocation(viewModel: PhotosLocation.Loaded.ViewModel) {
        mapView.addAnnotations(viewModel.annotations)
    }
}

extension DetailMapViewController: MKMapViewDelegate {
    
    /// - Tag: Create Anotataion View
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let view = mapView.dequeueReusableAnnotationView(withIdentifier: PhotoAnnotation.reuseIdentifier, for: annotation)
        
        guard !(annotation is MKUserLocation) else { return nil }
        if let markerAnnotationView = view as? MKMarkerAnnotationView {
            markerAnnotationView.markerTintColor = .systemYellow
            markerAnnotationView.glyphImage = UIImage(systemName: "camera")
        }
        return view
    }
}
