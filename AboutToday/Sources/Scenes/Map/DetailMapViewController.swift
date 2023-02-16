//
//  DetailMapViewController.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/16.
//

import UIKit
import MapKit

protocol DetailMapDisplayLogic {
    
}

final class DetailMapViewController: ViewController {

    let contetnView = DetailMapView()
    
    //MARK: - Life Cycle
    override func loadView() {
        view = contetnView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
