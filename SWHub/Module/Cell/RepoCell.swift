//
//  RepoCell.swift
//  SWHub
//
//  Created by liaoya on 2021/4/25.
//

import UIKit

class RepoCell: CollectionCell, ReactorKit.View {

    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.sizeToFit()
        imageView.size = .init(24)
        imageView.cornerRadius = imageView.height / 2.0
        return imageView
    }()
    
    lazy var titleLabel: SWLabel = {
        let label = SWLabel()
        label.font = .systemFont(ofSize: 17)
        label.sizeToFit()
        return label
    }()
    
    lazy var rankingLabel: SWLabel = {
        let label = SWLabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 11)
        label.sizeToFit()
        label.size = .init(20)
        label.cornerRadius = label.height / 2.0
        return label
    }()

    lazy var langLabel: SWLabel = {
        let label = SWLabel()
        label.sizeToFit()
        return label
    }()
    
    lazy var starLabel: SWLabel = {
        let label = SWLabel()
        label.sizeToFit()
        label.size = .init(width: 50, height: 25)
        return label
    }()
    
//    lazy var detailLabel: SWLabel = {
//        let label = SWLabel()
//        label.font = .systemFont(ofSize: 14)
//        label.textAlignment = .right
//        label.sizeToFit()
//        return label
//    }()
//
//
//    lazy var indicatorImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage.indicator.template
//        imageView.sizeToFit()
//        return imageView
//    }()
//
//    lazy var mainView: UIView = {
//        let view = UIView()
//        view.cornerRadius = 8
//        return view
//    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.qmui_borderWidth = 1
        self.contentView.qmui_borderPosition = .bottom
        // self.contentView.backgroundColor = .random
//        self.contentView.addSubview(self.mainView)
//
        self.contentView.addSubview(self.iconImageView)
        self.contentView.addSubview(self.rankingLabel)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.langLabel)
        self.contentView.addSubview(self.starLabel)
//        self.mainView.addSubview(self.detailLabel)
//        self.mainView.addSubview(self.indicatorImageView)
//
        themeService.rx
            .bind({ $0.borderColor }, to: self.contentView.rx.qmui_borderColor)
            .bind({ $0.backgroundColor }, to: self.rankingLabel.rx.textColor)
            .bind({ $0.primaryColor }, to: [
                self.titleLabel.rx.textColor,
                self.rankingLabel.rx.backgroundColor
            ])
            .disposed(by: self.rx.disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = nil
        self.rankingLabel.text = nil
        self.langLabel.attributedText = nil
        self.starLabel.attributedText = nil
        self.iconImageView.image = nil
//        self.titleLabel.text = nil
//        self.detailLabel.text = nil
//        self.indicatorImageView.isHidden = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.iconImageView.left = 15
        self.iconImageView.top = 10
        self.rankingLabel.right = self.contentView.width - 10
        self.rankingLabel.centerY = self.iconImageView.centerY
        self.titleLabel.sizeToFit()
        self.titleLabel.left = self.iconImageView.right + 5
        self.titleLabel.extendToRight = self.rankingLabel.left - 10
        self.titleLabel.centerY = self.iconImageView.centerY
        self.langLabel.sizeToFit()
        self.langLabel.left = self.iconImageView.left
        self.langLabel.bottom = self.contentView.height - 5
        self.starLabel.right = self.contentView.width - 5
        self.starLabel.centerY = self.langLabel.centerY
//        self.mainView.width = self.contentView.width - 20 * 2
//        self.mainView.height = self.contentView.height - 5 * 2
//        self.mainView.left = self.mainView.leftWhenCenter
//        self.mainView.top = self.mainView.topWhenCenter
//
//        self.iconImageView.sizeToFit()
//        self.iconImageView.left = 10
//        self.iconImageView.top = self.iconImageView.topWhenCenter
//
//        self.titleLabel.sizeToFit()
//        self.titleLabel.left = self.iconImageView.right + 10
//        self.titleLabel.top = self.titleLabel.topWhenCenter
//
//        self.indicatorImageView.right = self.mainView.width - 10
//        self.indicatorImageView.top = self.indicatorImageView.topWhenCenter
//
//        self.detailLabel.sizeToFit()
//        self.detailLabel.right = self.indicatorImageView.isHidden ?
//            self.indicatorImageView.centerX :
//            self.indicatorImageView.left - 8
//        self.detailLabel.top = self.detailLabel.topWhenCenter
//
//        if self.titleLabel.right >= self.detailLabel.left {
//            self.titleLabel.extendToRight = self.detailLabel.left - 8
//        }
    }

    func bind(reactor: RepoItem) {
        super.bind(item: reactor)
        reactor.state.map { $0.title }
            .distinctUntilChanged()
            .bind(to: self.titleLabel.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map { ($0.ranking + 1).string }
            .distinctUntilChanged()
            .bind(to: self.rankingLabel.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.lang }
            .distinctUntilChanged()
            .bind(to: self.langLabel.rx.attributedText)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.star }
            .distinctUntilChanged()
            .bind(to: self.starLabel.rx.attributedText)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.icon }
            .distinctUntilChanged { SWHub.compare($0, $1) }
            .bind(to: self.iconImageView.rx.imageSource)
            .disposed(by: self.disposeBag)
//        reactor.state.map { $0.icon == nil }
//            .bind(to: self.iconImageView.rx.isHidden)
//            .disposed(by: self.disposeBag)
//        reactor.state.map { !$0.indicated }
//            .bind(to: self.indicatorImageView.rx.isHidden)
//            .disposed(by: self.disposeBag)
        reactor.state.map { _ in }
            .bind(to: self.rx.setNeedsLayout)
            .disposed(by: self.disposeBag)
    }

    override class func size(width: CGFloat, item: BaseCollectionItem) -> CGSize {
        return CGSize(width: width, height: 80)
    }

}
