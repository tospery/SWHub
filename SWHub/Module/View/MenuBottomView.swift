//
//  MenuBottomView.swift
//  SWHub
//
//  Created by liaoya on 2021/5/21.
//

import Foundation

class MenuBottomView: BaseView {
    
    struct Metric {
        static let buttonHeight = 32.f
    }
    
    lazy var sureButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.titleLabel?.font = .normal(15)
        button.setTitle(R.string.localizable.sure(), for: .normal)
        button.sizeToFit()
        button.height = Metric.buttonHeight
        button.cornerRadius = button.height / 2.f
        return button
    }()
    
    lazy var resetButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.titleLabel?.font = .normal(15)
        button.setTitle(R.string.localizable.reset(), for: .normal)
        button.sizeToFit()
        button.height = Metric.buttonHeight
        button.cornerRadius = button.height / 2.f
        button.borderWidth = 1.f
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.qmui_borderPosition = .top
        self.qmui_borderWidth = pixelOne
        self.addSubview(self.sureButton)
        self.addSubview(self.resetButton)
        themeService.rx
            .bind({ $0.borderColor }, to: [
                self.rx.qmui_borderColor,
                self.resetButton.rx.borderColor
            ])
            .bind({ $0.primaryColor }, to: self.sureButton.rx.backgroundColor)
            .bind({ $0.backgroundColor }, to: self.sureButton.rx.titleColor(for: .normal))
            .bind({ $0.foregroundColor }, to: self.resetButton.rx.titleColor(for: .normal))
            .disposed(by: self.rx.disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = (self.width * 0.4).flat
        let padding = 20.f
        let margin = ((self.width - width * 2 - padding) / 2.f).flat
        self.resetButton.width = width
        self.resetButton.left = margin
        self.resetButton.top = self.resetButton.topWhenCenter - metric(0, notched: 10)
        self.sureButton.width = width
        self.sureButton.left = self.resetButton.right + padding
        self.sureButton.centerY = self.resetButton.centerY
    }
    
}
