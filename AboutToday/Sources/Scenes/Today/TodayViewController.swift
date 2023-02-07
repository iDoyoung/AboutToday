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
    
    lazy var navigationLeftBarButtonItem: UIBarButtonItem = {
        let barbuttionItem = UIBarButtonItem(image: nil, style: .plain, target: self, action: nil)
        barbuttionItem.accessibilityLabel = "Today weather"
        return barbuttionItem
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
    }
    
    private func setLeftBarButtonItemImage(_ image: UIImage?) {
        assert(image != nil, "Image is nil")
        navigationLeftBarButtonItem.image = image
    }
}
