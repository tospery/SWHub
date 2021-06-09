//
//  TrendingUserCell.swift
//  SWHub
//
//  Created by liaoya on 2021/4/27.
//

import UIKit

class TrendingUserCell: BaseCollectionCell, ReactorKit.View {
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel.init()
        label.numberOfLines = 2
        label.font = .normal(16)
        label.sizeToFit()
        return label
    }()
    
    lazy var reponameLabel: UILabel = {
        let label = UILabel.init()
        label.sizeToFit()
        return label
    }()
    
    lazy var rankingLabel: UILabel = {
        let label = UILabel.init()
        label.textAlignment = .center
        label.font = .normal(11)
        label.sizeToFit()
        label.size = .init(18)
        label.cornerRadius = label.height / 2
        return label
    }()
    
    lazy var repodescLabel: UILabel = {
        let label = UILabel.init()
        label.numberOfLines = Metric.trendingMaxLines
        label.sizeToFit()
        return label
    }()
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.cornerRadius = 4
        imageView.sizeToFit()
        imageView.size = Metric.Trending.iconSize
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.qmui_borderWidth = pixelOne
        self.contentView.qmui_borderPosition = .bottom

        self.contentView.addSubview(self.avatarImageView)
        self.contentView.addSubview(self.rankingLabel)
        self.contentView.addSubview(self.usernameLabel)
        self.contentView.addSubview(self.reponameLabel)
        self.contentView.addSubview(self.repodescLabel)

        themeService.rx
            .bind({ $0.backgroundColor }, to: self.rankingLabel.rx.textColor)
            .bind({ $0.borderColor }, to: self.contentView.rx.qmui_borderColor)
            .bind({ $0.titleColor }, to: self.reponameLabel.rx.textColor)
            .bind({ $0.primaryColor }, to: [
                self.rankingLabel.rx.backgroundColor,
                self.usernameLabel.rx.textColor
            ])
            .disposed(by: self.rx.disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.rankingLabel.text = nil
        self.usernameLabel.attributedText = nil
        self.reponameLabel.attributedText = nil
        self.repodescLabel.attributedText = nil
        self.avatarImageView.image = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.avatarImageView.left = Metric.margin.left
        self.avatarImageView.top = Metric.margin.top
        self.rankingLabel.right = self.contentView.width - Metric.margin.right
        self.rankingLabel.centerY = self.avatarImageView.centerY
        self.usernameLabel.sizeToFit()
        self.usernameLabel.height = Metric.Trending.nameHeight
        self.usernameLabel.width = self.rankingLabel.left - Metric.padding
            - self.avatarImageView.right - Metric.padding
        self.usernameLabel.left = self.avatarImageView.right + Metric.padding
        self.usernameLabel.centerY = self.avatarImageView.centerY
        self.reponameLabel.sizeToFit()
        self.reponameLabel.height = Metric.Trending.subnameHeight
        self.reponameLabel.width = self.contentView.width - Metric.margin.left - Metric.margin.right
        self.reponameLabel.left = self.avatarImageView.left
        self.reponameLabel.top = self.avatarImageView.bottom + Metric.padding / 2.f
        self.repodescLabel.sizeToFit()
        self.repodescLabel.width = self.reponameLabel.width
        self.repodescLabel.left = self.reponameLabel.left
        self.repodescLabel.top = self.reponameLabel.bottom
        self.repodescLabel.extendToBottom = self.contentView.height - Metric.margin.bottom
    }

    func bind(reactor: TrendingUserItem) {
        super.bind(item: reactor)
        reactor.state.map { $0.ranking.string }
            .distinctUntilChanged()
            .bind(to: self.rx.ranking)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.username }
            .distinctUntilChanged()
            .bind(to: self.rx.username)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.reponame }
            .distinctUntilChanged()
            .bind(to: self.rx.reponame)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.repodesc }
            .distinctUntilChanged()
            .bind(to: self.rx.repodesc)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.avatar }
            .distinctUntilChanged { SWFrame.compareImage($0, $1) }
            .bind(to: self.rx.avatar)
            .disposed(by: self.disposeBag)
        reactor.state.map { _ in }
            .bind(to: self.rx.setNeedsLayout)
            .disposed(by: self.disposeBag)
    }

    override class func size(width: CGFloat, item: BaseCollectionItem) -> CGSize {
        guard let item = item as? TrendingUserItem else { return .zero }
        var height = 0.f
        height += Metric.margin.top
        height += Metric.Trending.iconSize.height
        height += Metric.padding
        height += Metric.Trending.subnameHeight
        let descHeight = UILabel.size(
            attributedString: item.currentState.repodesc,
            withConstraints: .init(
                width: UIScreen.width - Metric.margin.left - Metric.margin.right,
                height: .greatestFiniteMagnitude
            ),
            limitedToNumberOfLines: UInt(Metric.trendingMaxLines)
        ).height
        height += descHeight
        height += Metric.margin.bottom
        return CGSize(width: width, height: height.flat)
    }

}
