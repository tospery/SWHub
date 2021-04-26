//
//  RepoCell.swift
//  SWHub
//
//  Created by liaoya on 2021/4/25.
//

import UIKit

class RepoCell: CollectionCell, ReactorKit.View {

    struct Metric {
        static let iconSize = CGSize.init(24)
        static let rankingSize = CGSize.init(20)
    }
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.sizeToFit()
        imageView.size = Metric.iconSize
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
        label.size = Metric.rankingSize
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
        label.size = .init(width: 60, height: 25)
        return label
    }()
    
    lazy var descLabel: SWLabel = {
        let label = SWLabel()
        label.numberOfLines = 2
        label.sizeToFit()
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.qmui_borderWidth = 1
        self.contentView.qmui_borderPosition = .bottom

        self.contentView.addSubview(self.iconImageView)
        self.contentView.addSubview(self.rankingLabel)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.langLabel)
        self.contentView.addSubview(self.starLabel)
        self.contentView.addSubview(self.descLabel)

        themeService.rx
            .bind({ $0.borderColor }, to: self.contentView.rx.qmui_borderColor)
            .bind({ $0.backgroundColor }, to: self.rankingLabel.rx.textColor)
            .bind({ $0.titleColor }, to: self.descLabel.rx.textColor)
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
        self.descLabel.attributedText = nil
        self.iconImageView.image = nil
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
        self.descLabel.sizeToFit()
        self.descLabel.width = self.contentView.width - 15 - 10
        self.descLabel.height = self.langLabel.top - self.iconImageView.bottom - 10
        self.descLabel.left = self.iconImageView.left
        self.descLabel.top = self.iconImageView.bottom + 5
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
        reactor.state.map { $0.desc }
            .distinctUntilChanged()
            .bind(to: self.descLabel.rx.attributedText)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.star }
            .distinctUntilChanged()
            .bind(to: self.starLabel.rx.attributedText)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.icon }
            .distinctUntilChanged { SWHub.compare($0, $1) }
            .bind(to: self.iconImageView.rx.imageSource)
            .disposed(by: self.disposeBag)
        reactor.state.map { _ in }
            .bind(to: self.rx.setNeedsLayout)
            .disposed(by: self.disposeBag)
    }

    override class func size(width: CGFloat, item: BaseCollectionItem) -> CGSize {
        guard let item = item as? RepoItem else { return .zero }
        var height = UILabel.size(
            attributedString: item.currentState.desc,
            withConstraints: .init(width: UIScreen.width - 15 - 10, height: .greatestFiniteMagnitude),
            limitedToNumberOfLines: 2
        ).height
        height += 10
        height += Metric.iconSize.height
        height += 5
        height += 5
        height += Metric.rankingSize.height
        height += 5
        return CGSize(width: width, height: height.flat)
    }

}
