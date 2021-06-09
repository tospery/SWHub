//
//  LanguageCell.swift
//  SWHub
//
//  Created by liaoya on 2021/5/21.
//

import UIKit

class LanguageCell: BaseCollectionCell, ReactorKit.View {
    
    lazy var label: UILabel = {
        let label = UILabel.init()
        label.font = .normal(15)
        label.sizeToFit()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.label)
        themeService.rx
            .bind({ $0.titleColor }, to: self.label.rx.textColor)
            .disposed(by: self.rx.disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.label.text = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.label.sizeToFit()
        self.label.left = 10
        self.label.top = self.label.topWhenCenter
    }

    func bind(reactor: LanguageItem) {
        super.bind(item: reactor)
        reactor.state.map { $0.name }
            .distinctUntilChanged()
            .bind(to: self.label.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map { _ in }
            .bind(to: self.rx.setNeedsLayout)
            .disposed(by: self.disposeBag)
    }

    override class func size(width: CGFloat, item: BaseCollectionItem) -> CGSize {
        .init(width: width, height: 44)
    }

}
