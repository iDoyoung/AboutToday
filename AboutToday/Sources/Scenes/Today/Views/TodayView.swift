//
//  TodayView.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/07.
//

import UIKit
import FlexLayout
import PinLayout

final class TodayView: UIView {
    
    let rootFlexContainer = UIView()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        
        addSubview(rootFlexContainer)
        rootFlexContainer.flex
            .direction(.column)
            .padding(0)
            .define { flex in
                ///First Row Containter
                flex.addItem()
                    .direction(.row)
                    .define { flex in
                        //TODO: Add Weather View
                    }
            }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rootFlexContainer.pin.all(self.pin.safeArea)
        rootFlexContainer.flex.layout()
    }
}
