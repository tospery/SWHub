//
//  SchemeCell.swift
//  SWHub
//
//  Created by liaoya on 2021/5/24.
//

import UIKit

class SchemeCell: BaseCollectionCell, ReactorKit.View {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel.init()
        label.font = .normal(15)
        label.sizeToFit()
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel.init()
        label.font = .normal(12)
        label.sizeToFit()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.qmui_borderWidth = pixelOne
        self.contentView.qmui_borderPosition = .bottom
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.subtitleLabel)
        
        themeService.rx
            .bind({ $0.borderColor }, to: self.contentView.rx.qmui_borderColor)
            .bind({ $0.titleColor }, to: self.titleLabel.rx.textColor)
            .bind({ $0.bodyColor }, to: self.subtitleLabel.rx.textColor)
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
        self.titleLabel.sizeToFit()
        self.titleLabel.left = 15
        self.titleLabel.top = 5
        self.subtitleLabel.sizeToFit()
        self.subtitleLabel.left = self.titleLabel.left
        self.subtitleLabel.bottom = self.contentView.bottom - 5
    }

    func bind(reactor: SchemeItem) {
        super.bind(item: reactor)
        reactor.state.map { $0.title }
            .distinctUntilChanged()
            .bind(to: self.titleLabel.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.subtitle }
            .distinctUntilChanged()
            .bind(to: self.subtitleLabel.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map { _ in }
            .bind(to: self.rx.setNeedsLayout)
            .disposed(by: self.disposeBag)
    }
    
    override class func size(width: CGFloat, item: BaseCollectionItem) -> CGSize {
        .init(width: width, height: 44)
    }

}
