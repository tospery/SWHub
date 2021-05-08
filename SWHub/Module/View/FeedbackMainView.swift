//
//  FeedbackMainView.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/2.
//

import UIKit

class FeedbackMainView: BaseView {
    
    lazy var label: SWLabel = {
        let label = SWLabel.init()
        label.qmui_borderWidth = 1
        label.qmui_borderPosition = .top
        label.font = .systemFont(ofSize: 15)
        label.contentEdgeInsets = .init(horizontal: 10, vertical: 0)
        label.sizeToFit()
        label.height = 40
        return label
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView.init()
        textView.font = .systemFont(ofSize: 15)
        textView.placeholder = R.string.localizable.feedbackPlaceholder()
        textView.sizeToFit()
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.label)
        self.addSubview(self.textView)
        
        themeService.rx
            .bind({ $0.borderColor }, to: self.label.rx.qmui_borderColor)
            .bind({ $0.bodyColor }, to: self.textView.rx.textColor)
            .bind({ $0.footerColor }, to: self.textView.rx.placeholderColor)
            .disposed(by: self.rx.disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        .init(width: UIScreen.width, height: 200)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.label.width = self.width
        self.label.left = 0
        self.label.bottom = self.height
        self.textView.width = self.width - 10
        self.textView.height = self.height - self.label.height - 10
        self.textView.left = 5
        self.textView.top = 5
    }

}
