//
//  TodayViewController.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/02.
//

import UIKit

protocol TodayDisplayLogic: AnyObject {
}

final class TodayViewController: ViewController, TodayDisplayLogic {
    
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
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = navigationLeftBarButtonItem
    }
    
    func displayNavigationBarLeftItem(weather image: UIImage) {
        navigationLeftBarButtonItem.image = image
    }
}
