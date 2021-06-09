//
//  TextViewCell.swift
//  SWHub
//
//  Created by liaoya on 2021/5/28.
//

import UIKit

class TextViewCell: BaseCollectionCell, ReactorKit.View {
    
    let maxChars = 160
    
    lazy var label: UILabel = {
        let label = UILabel.init()
        label.font = .normal(14)
        label.textAlignment = .right
        label.sizeToFit()
        label.height = label.font.lineHeight
        label.width = 55
        return label
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView.init()
        textView.font = .normal(16)
        textView.sizeToFit()
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.textView)
        self.contentView.addSubview(self.label)
        self.textView.rx.text
            .subscribeNext(weak: self, type(of: self).handleText)
            .disposed(by: self.disposeBag)
        themeService.rx
            .bind({ $0.titleColor }, to: self.textView.rx.textColor)
            .bind({ $0.headerColor }, to: self.label.rx.textColor)
            .disposed(by: self.rx.disposeBag)
    }
    
    func handleText(text: String?) {
        if let text = text, text.count > self.maxChars {
            self.textView.text = String.init(text.prefix(self.maxChars))
        }
        self.label.text = "\(text?.count ?? 0)/\(self.maxChars)"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.textView.sizeToFit()
        self.textView.width = self.contentView.width - 20 * 2
        self.textView.height = self.contentView.height
        self.textView.left = self.textView.leftWhenCenter
        self.textView.top = self.textView.topWhenCenter
        self.label.right = self.textView.right
        self.label.bottom = self.textView.bottom - 10
    }

    func bind(reactor: TextViewItem) {
        super.bind(item: reactor)
        reactor.state.map { $0.text }
            .distinctUntilChanged()
            .bind(to: self.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map { _ in }
            .bind(to: self.rx.setNeedsLayout)
            .disposed(by: self.disposeBag)
    }
    
    override class func size(width: CGFloat, item: BaseCollectionItem) -> CGSize {
        .init(width: width, height: 140)
    }

}
