//
//  RepoStatView.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/15.
//

import Foundation

class RepoStatView: BaseView {
    
    lazy var watchesButton: SWFButton = {
        let button = SWFButton.init(type: .custom)
        button.titleLabel?.numberOfLines = 2
        return button
    }()
    
    lazy var starsButton: SWFButton = {
        let button = SWFButton.init(type: .custom)
        button.titleLabel?.numberOfLines = 2
        return button
    }()
    
    lazy var forksButton: SWFButton = {
        let button = SWFButton.init(type: .custom)
        button.titleLabel?.numberOfLines = 2
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.qmui_borderPosition = .top
        self.qmui_borderWidth = pixelOne
        self.addSubview(self.watchesButton)
        self.addSubview(self.starsButton)
        self.addSubview(self.forksButton)
        themeService.rx
            .bind({ $0.borderColor }, to: self.rx.qmui_borderColor)
            .disposed(by: self.rx.disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        .init(width: UIScreen.width, height: 55)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = ((self.width - 40) / 3).flat
        self.watchesButton.sizeToFit()
        self.watchesButton.width = width
        self.watchesButton.height = self.height
        self.watchesButton.left = 20
        self.watchesButton.top = 0
        self.starsButton.sizeToFit()
        self.starsButton.width = width
        self.starsButton.height = self.height
        self.starsButton.left = self.watchesButton.right
        self.starsButton.top = 0
        self.forksButton.sizeToFit()
        self.forksButton.width = width
        self.forksButton.height = self.height
        self.forksButton.left = self.starsButton.right
        self.forksButton.top = 0
    }
    
}
