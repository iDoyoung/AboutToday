//
//  TodayViewController.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/02.
//

import UIKit
import MapKit

protocol TodayDisplayLogic: AnyObject {
    func displayWeather(viewModel: TodayWeather.Fetched.ViewModel)
    func displayLocationError()
    func displayCurrentLocation(region: MKCoordinateRegion)
    func displayPhotos(viewModel: PhotoImage.Fetched.ViewModel)
}

final class TodayViewController: ViewController, TodayDisplayLogic {
    
    var interactor: TodayBusinessLogic?
    
    enum Section: CaseIterable {
        case photos
    }
    
    //MARK: UI Properties
    var contentView = TodayView()
    var dataSource: UICollectionViewDiffableDataSource<Section, UIImage>?
    
    private lazy var navigationLeftBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(image: nil, style: .plain, target: self, action: nil)
        barButtonItem.accessibilityLabel = "Today weather"
        return barButtonItem
    }()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        setupNavigationBar()
        interactor?.startUpdatingLocation()
    }
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interactor?.requestCurrentLocation()
        interactor?.requestPhotoImages(size: .zero)
    }
    //TODO: Should Call Interactor to request Location
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .systemMint
        navigationItem.leftBarButtonItem = navigationLeftBarButtonItem
        navigationItem.rightBarButtonItem = createRightBarButtonItem()
    }
    
     private func setLeftBarButtonItemImage(_ image: UIImage?) {
        assert(image != nil, "Image is nil")
        navigationLeftBarButtonItem.image = image
    }
    
    private func createRightBarButtonItem() -> UIBarButtonItem {
        let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "map"), style: .plain, target: self, action: nil)
        return barButtonItem
    }
    
    private func setCityLabel(text: String) {
        contentView.todayWeatherView.cityLabel.text = text
    }
    
    private func setCurrentTempLabel(text: String) {
        contentView.todayWeatherView.currentTempLabel.text = text
    }
    
    private func setMaxTempLabel(text: String) {
        contentView.todayWeatherView.maxTempLabel.text = text
    }
    
    private func setMinTempLabel(text: String) {
        contentView.todayWeatherView.minTempLabel.text = text
    }
    
    //MARK: - Display Logic
    func displayCurrentLocation(region: MKCoordinateRegion) {
        contentView.currentLocationMapView.mapView.setRegion(region, animated: false)
        interactor?.loadWeather()
    }
    
    func displayLocationError() {
        contentView.currentLocationMapView.toggleMapVisibility(hide: true)
    }
    
    func displayWeather(viewModel: TodayWeather.Fetched.ViewModel) {
        assert(Thread.isMainThread, "Thread is not main")
        setLeftBarButtonItemImage(viewModel.image)
        setCityLabel(text: viewModel.city)
        setCurrentTempLabel(text: viewModel.currentTemperature)
        setMaxTempLabel(text: viewModel.maxTemperature)
        setMinTempLabel(text: viewModel.minTemperature)
        contentView.todayWeatherView.setNeedsLayout()
    }
    
    func displayPhotos(viewModel: PhotoImage.Fetched.ViewModel) {
        applyTodayPhotosSnapshot(viewModel.images)
    }
}

//MARK: - Collection View
extension TodayViewController {
    
    private func configureDataSource() {
        let todayPhotoCellRegistration = createTodayPhotoCellRegistration()
        dataSource = UICollectionViewDiffableDataSource<Section, UIImage>(collectionView: contentView.photoCollectionView) { collectionView, indexPath, itemIdentifier in
            collectionView.dequeueConfiguredReusableCell(using: todayPhotoCellRegistration, for: indexPath, item: itemIdentifier)
        }
        initailSnapshot()
    }
    
    ///Create Cell Registration
    private func createTodayPhotoCellRegistration() -> UICollectionView.CellRegistration<TodayPhotoCell, UIImage> {
        return UICollectionView.CellRegistration<TodayPhotoCell, UIImage> { cell, indexPath, image in
            cell.photoImageView.image = image
        }
    }
    
    ///Snapshot
    private func initailSnapshot() {
        let sections = Section.allCases
        var snapshot = NSDiffableDataSourceSnapshot<Section, UIImage>()
        snapshot.appendSections(sections)
        dataSource?.apply(snapshot)
        applyTodayPhotosSnapshot([])
    }
    
    private func applyTodayPhotosSnapshot(_ items: [UIImage]) {
        var snapshot = NSDiffableDataSourceSectionSnapshot<UIImage>()
        snapshot.append(items)
        dataSource?.apply(snapshot, to: .photos)
    }
}
