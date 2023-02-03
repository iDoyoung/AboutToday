//
//  TodayViewController.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/02.
//

import UIKit

protocol TodayDisplayLogic: AnyObject {
    func displayNavigationBarLeftItem(weather image: UIImage)
}

final class TodayViewController: ViewController, TodayDisplayLogic {
    
    var interactor: TodayBusinessLogic?
    
    lazy var navigationLeftBarButtonItem: UIBarButtonItem = {
        let barbuttionItem = UIBarButtonItem(image: UIImage(systemName: "questionmark"), style: .plain, target: self, action: nil)
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
        interactor?.loadWeather()
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = navigationLeftBarButtonItem
    }
    
    func displayNavigationBarLeftItem(weather image: UIImage) {
        navigationLeftBarButtonItem.image = image
    }
}
