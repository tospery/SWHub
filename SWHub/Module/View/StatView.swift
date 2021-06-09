//
//  StatView.swift
//  SWHub
//
//  Created by liaoya on 2021/5/31.
//

import UIKit

class StatView: BaseView {
    
    struct Metric {
        static let height = 55.f
    }
    
    lazy var leftButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.titleLabel?.numberOfLines = 2
        button.sizeToFit()
        return button
    }()
    
    lazy var centerButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.titleLabel?.numberOfLines = 2
        button.sizeToFit()
        return button
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.titleLabel?.numberOfLines = 2
        button.sizeToFit()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.qmui_borderPosition = .top
        self.qmui_borderWidth = pixelOne
        
        self.addSubview(self.leftButton)
        self.addSubview(self.centerButton)
        self.addSubview(self.rightButton)
        
        themeService.rx
            .bind({ $0.borderColor }, to: self.rx.qmui_borderColor)
            .disposed(by: self.rx.disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = ((self.width - metric(10) * 2) / 3).flat
        let size = CGSize.init(width: width, height: self.height)
        self.centerButton.size = size
        self.centerButton.left = self.centerButton.leftWhenCenter
        self.centerButton.top = self.centerButton.topWhenCenter
        self.leftButton.size = size
        self.leftButton.right = self.centerButton.left
        self.leftButton.top = 0
        self.rightButton.size = size
        self.rightButton.left = self.centerButton.right
        self.rightButton.top = 0
    }

}
