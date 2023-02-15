//
//  WeatherDetailViewController.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/14.
//

import UIKit

protocol WeatherDetailDisplayLogic: AnyObject {
}
    
final class WeatherDetailViewController: ViewController, WeatherDetailDisplayLogic {

    var interactor: (WeatherDetailBusinessLogic&WeatherDetailDataStore)?
    var router: WeatherDetailDataPassing?
    //MARK: - UI Properties
    var contentView = WeatherDetailView()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
