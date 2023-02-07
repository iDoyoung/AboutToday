//
//  TodayViewController.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/02.
//

import UIKit

protocol TodayDisplayLogic: AnyObject {
    func displayWeather(viewModel: TodayWeather.Fetched.ViewModel)
}

final class TodayViewController: ViewController, TodayDisplayLogic {
    
    var interactor: TodayBusinessLogic?
    
    //MARK: UI Properties
    private lazy var navigationLeftBarButtonItem: UIBarButtonItem = {
        let barButtionItem = UIBarButtonItem(image: nil, style: .plain, target: self, action: nil)
        barButtionItem.accessibilityLabel = "Today weather"
        return barButtionItem
    }()
    
    private let weatherView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let locationView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()
    
    private let currentTempLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    private let maxTempLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption2)
        return label
    }()
    
    private let minTempLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption2)
        return label
    }()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.loadWeather()
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = navigationLeftBarButtonItem
    }
    
    //MARK: - Display Logic
    func displayWeather(viewModel: TodayWeather.Fetched.ViewModel) {
        assert(Thread.isMainThread, "Thread is not main")
        setLeftBarButtonItemImage(viewModel.image)
        setCityLabel(text: viewModel.city)
        setCurrentTempLabel(text: viewModel.currentTemperature)
        setMaxTempLabel(text: viewModel.maxTemperature)
        setMinTempLabel(text: viewModel.minTemperature)
    }
    
    private func setLeftBarButtonItemImage(_ image: UIImage?) {
        assert(image != nil, "Image is nil")
        navigationLeftBarButtonItem.image = image
    }
    
    private func setCityLabel(text: String) {
        cityLabel.text = text
    }
    
    private func setCurrentTempLabel(text: String) {
        currentTempLabel.text = text
    }
    
    private func setMaxTempLabel(text: String) {
        maxTempLabel.text = text
    }
    
    private func setMinTempLabel(text: String) {
        minTempLabel.text = text
    }
    
}
