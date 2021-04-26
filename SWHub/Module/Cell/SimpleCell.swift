//
//  SimpleCell.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import UIKit

class SimpleCell: CollectionCell, ReactorKit.View {

    lazy var titleLabel: SWLabel = {
        let label = SWLabel()
        label.font = .systemFont(ofSize: 16)
        label.sizeToFit()
        return label
    }()

    lazy var detailLabel: SWLabel = {
        let label = SWLabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .right
        label.sizeToFit()
        return label
    }()

    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.sizeToFit()
        return imageView
    }()

    lazy var indicatorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.indicator.template
        imageView.sizeToFit()
        return imageView
    }()

    lazy var mainView: UIView = {
        let view = UIView()
        view.cornerRadius = 8
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.mainView)

        self.mainView.addSubview(self.iconImageView)
        self.mainView.addSubview(self.titleLabel)
        self.mainView.addSubview(self.detailLabel)
        self.mainView.addSubview(self.indicatorImageView)

        themeService.rx
            .bind({ $0.backgroundColor }, to: self.mainView.rx.backgroundColor)
            .bind({ $0.borderColor }, to: self.rx.qmui_borderColor)
            .bind({ $0.titleColor }, to: self.titleLabel.rx.textColor)
            .bind({ $0.headerColor }, to: self.detailLabel.rx.textColor)
            .bind({ $0.indicatorColor }, to: [self.iconImageView.rx.tintColor, self.indicatorImageView.rx.tintColor])
            .disposed(by: self.rx.disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = nil
        self.detailLabel.text = nil
        self.iconImageView.image = nil
        self.indicatorImageView.isHidden = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.mainView.width = self.contentView.width - 20 * 2
        self.mainView.height = self.contentView.height - 5 * 2
        self.mainView.left = self.mainView.leftWhenCenter
        self.mainView.top = self.mainView.topWhenCenter

        self.iconImageView.sizeToFit()
        self.iconImageView.left = 10
        self.iconImageView.top = self.iconImageView.topWhenCenter

        self.titleLabel.sizeToFit()
        self.titleLabel.left = self.iconImageView.right + 10
        self.titleLabel.top = self.titleLabel.topWhenCenter

        self.indicatorImageView.right = self.mainView.width - 10
        self.indicatorImageView.top = self.indicatorImageView.topWhenCenter

        self.detailLabel.sizeToFit()
        self.detailLabel.right = self.indicatorImageView.isHidden ?
            self.indicatorImageView.centerX :
            self.indicatorImageView.left - 8
        self.detailLabel.top = self.detailLabel.topWhenCenter
        
        if self.titleLabel.right >= self.detailLabel.left {
            self.titleLabel.extendToRight = self.detailLabel.left - 8
        }
    }

    func bind(reactor: SimpleItem) {
        super.bind(item: reactor)
        reactor.state.map { $0.title }
            .distinctUntilChanged()
            .bind(to: self.titleLabel.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.detail }
            .bind(to: self.detailLabel.rx.attributedText)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.icon }
            .distinctUntilChanged({ (left, right) -> Bool in
                compare(left, right)
            })
            .bind(to: self.iconImageView.rx.imageSource)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.icon == nil }
            .bind(to: self.iconImageView.rx.isHidden)
            .disposed(by: self.disposeBag)
        reactor.state.map { !$0.indicated }
            .bind(to: self.indicatorImageView.rx.isHidden)
            .disposed(by: self.disposeBag)
        reactor.state.map { _ in }
            .bind(to: self.rx.setNeedsLayout)
            .disposed(by: self.disposeBag)
    }

    override class func size(width: CGFloat, item: BaseCollectionItem) -> CGSize {
        return CGSize(width: width, height: metric(60))
    }

}
