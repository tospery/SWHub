//
//  FeedbackInputCell.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/29.
//

import UIKit

class FeedbackInputCell: BaseCollectionCell, ReactorKit.View {
    
    lazy var label: SWFLabel = {
        let label = SWFLabel.init(frame: .zero)
        label.qmui_borderWidth = pixelOne
        label.qmui_borderPosition = .top
        label.font = .normal(13)
        label.textInsets = .init(horizontal: 10, vertical: 0)
        label.sizeToFit()
        label.height = 30
        return label
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView.init()
        textView.font = .normal(15)
        textView.placeholder = R.string.localizable.feedbackPlaceholder()
        textView.sizeToFit()
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.label)
        self.contentView.addSubview(self.textView)
        
        themeService.rx
            .bind({ $0.borderColor }, to: self.label.rx.qmui_borderColor)
            .bind({ $0.titleColor }, to: self.textView.rx.textColor)
            .bind({ $0.bodyColor }, to: self.label.rx.textColor)
            .bind({ $0.footerColor }, to: self.textView.rx.placeholderColor)
            .disposed(by: self.rx.disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.label.width = self.contentView.width
        self.label.left = 0
        self.label.bottom = self.contentView.height
        self.textView.width = self.contentView.width - 10
        self.textView.height = self.contentView.height - self.label.height - 10
        self.textView.left = 5
        self.textView.top = 5
    }

    func bind(reactor: FeedbackInputItem) {
        super.bind(item: reactor)
        reactor.state.map { $0.title }
            .distinctUntilChanged()
            .bind(to: self.rx.title)
            .disposed(by: self.disposeBag)
//        reactor.state.map { $0.body }
//            .distinctUntilChanged()
//            .bind(to: self.rx.body)
//            .disposed(by: self.disposeBag)
        reactor.state.map { _ in }
            .bind(to: self.rx.setNeedsLayout)
            .disposed(by: self.disposeBag)
    }
    
    override class func size(width: CGFloat, item: BaseCollectionItem) -> CGSize {
        .init(width: width, height: metric(180))
    }

}
