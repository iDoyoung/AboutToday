//
//  DetailMapViewController.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/16.
//

import UIKit
import MapKit

protocol DetailMapDisplayLogic: AnyObject {
}

final class DetailMapViewController: ViewController, DetailMapDisplayLogic {

    let contetnView = DetailMapView()
    var interactor: DetailMapBusinessLogic?
    var router: (DetailMapRouting&DetailMapDataPassing)?
    
    //MARK: - Life Cycle
    override func loadView() {
        view = contetnView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
