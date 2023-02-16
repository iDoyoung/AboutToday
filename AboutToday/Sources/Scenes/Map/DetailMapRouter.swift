//
//  DetailMapRouter.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/16.
//

import UIKit

protocol DetailMapRouting { }
protocol DetailMapDataPassing {
    var dataStore: DetailMapDataStore? { get }
}

final class DetailMapRouter: DetailMapRouting, DetailMapDataPassing {
    
    weak var viewController: DetailMapViewController?
    var dataStore: DetailMapDataStore?
}
