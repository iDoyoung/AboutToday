//
//  ViewController.swift
//  AboutToday
//
//  Created by Doyoung on 2023/01/31.
//

import UIKit

///Base parent UIViewController to check for Memory leak
class ViewController: UIViewController {
    
    deinit {
        #if DEBUG
        print("Deinit View Controller")
        #endif
    }
}

