//
//  RepoCell.swift
//  SWHub
//
//  Created by liaoya on 2021/5/21.
//

import UIKit

class RepoCell: BaseCollectionCell, ReactorKit.View {

    let usernameSubject = PublishSubject<String>()
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.repo()
        imageView.sizeToFit()
        imageView.size = Metric.Trending.iconSize
        return imageView
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
    
    lazy var reponameLabel: SWFLabel = {
        let label = SWFLabel.init(frame: .zero)
        label.delegate = self
        label.verticalAlignment = .center
        label.numberOfLines = 2
        label.font = .normal(16)
        label.sizeToFit()
        return label
    }()
    
    lazy var starsLabel: UILabel = {
        let label = UILabel.init()
        label.sizeToFit()
        label.size = Metric.Trending.starsSize
        return label
    }()
    
    lazy var statusLabel: UILabel = {
        let label = UILabel.init()
        label.font = .normal(13)
        label.sizeToFit()
        label.height = Metric.repoStatusHeight
        return label
    }()
    
    lazy var languageLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        return label
    }()
    
    lazy var descLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = Metric.trendingMaxLines
        label.sizeToFit()
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.qmui_borderWidth = pixelOne
        self.contentView.qmui_borderPosition = .bottom
        
        self.contentView.addSubview(self.iconImageView)
        self.contentView.addSubview(self.rankingLabel)
        self.contentView.addSubview(self.reponameLabel)
        self.contentView.addSubview(self.starsLabel)
        self.contentView.addSubview(self.languageLabel)
        self.contentView.addSubview(self.descLabel)
        self.contentView.addSubview(self.statusLabel)

        themeService.rx
            .bind({ $0.borderColor }, to: self.contentView.rx.qmui_borderColor)
            .bind({ $0.titleColor }, to: [
                self.descLabel.rx.textColor,
                self.reponameLabel.rx.textColor
            ])
            .bind({ $0.foregroundColor }, to: self.statusLabel.rx.textColor)
            .bind({ $0.backgroundColor }, to: self.rankingLabel.rx.textColor)
            .bind({ $0.primaryColor }, to: self.rankingLabel.rx.backgroundColor)
            .disposed(by: self.rx.disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.rankingLabel.text = nil
        self.reponameLabel.text = nil
        self.starsLabel.attributedText = nil
        self.languageLabel.attributedText = nil
        self.descLabel.attributedText = nil
        self.statusLabel.text = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.iconImageView.left = Metric.margin.left
        self.iconImageView.top = Metric.margin.top
        self.rankingLabel.right = self.contentView.width - Metric.margin.right
        self.rankingLabel.centerY = self.iconImageView.centerY
        self.reponameLabel.sizeToFit()
        self.reponameLabel.height = Metric.Trending.nameHeight
        self.reponameLabel.width = self.rankingLabel.left - Metric.padding
            - self.iconImageView.right - Metric.padding
        self.reponameLabel.left = self.iconImageView.right + Metric.padding
        self.reponameLabel.centerY = self.iconImageView.centerY
        self.starsLabel.right = self.contentView.width
        self.starsLabel.bottom = self.contentView.height
        self.languageLabel.sizeToFit()
        self.languageLabel.left = self.iconImageView.left
        self.languageLabel.centerY = self.starsLabel.centerY
        self.statusLabel.sizeToFit()
        self.statusLabel.height = Metric.repoStatusHeight
        self.statusLabel.left = self.iconImageView.left
        self.statusLabel.bottom = self.languageLabel.top - Metric.padding / 2.f
        self.descLabel.sizeToFit()
        self.descLabel.width = self.contentView.width - self.iconImageView.left - Metric.margin.right
        self.descLabel.height = self.statusLabel.top - self.iconImageView.bottom - Metric.padding
        self.descLabel.left = self.iconImageView.left
        self.descLabel.top = self.iconImageView.bottom + Metric.padding / 2.f
    }

    func bind(reactor: RepoItem) {
        super.bind(item: reactor)
        reactor.state.map { $0.ranking?.string }
            .distinctUntilChanged()
            .bind(to: self.rx.ranking)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.ranking == nil }
            .distinctUntilChanged()
            .bind(to: self.rankingLabel.rx.isHidden)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.reponame }
            .distinctUntilChanged()
            .bind(to: self.rx.reponame)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.status }
            .distinctUntilChanged()
            .bind(to: self.rx.status)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.stars }
            .distinctUntilChanged()
            .bind(to: self.starsLabel.rx.attributedText)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.language }
            .distinctUntilChanged()
            .bind(to: self.languageLabel.rx.attributedText)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.desc }
            .distinctUntilChanged()
            .bind(to: self.descLabel.rx.attributedText)
            .disposed(by: self.disposeBag)
        reactor.state.map { _ in }
            .bind(to: self.rx.setNeedsLayout)
            .disposed(by: self.disposeBag)
    }

    override class func size(width: CGFloat, item: BaseCollectionItem) -> CGSize {
        guard let item = item as? RepoItem else { return .zero }
        var height = 0.f
        height += Metric.margin.top
        height += Metric.Trending.iconSize.height
        height += Metric.padding
        height += Metric.Trending.starsSize.height
        let descHeight = UILabel.size(
            attributedString: item.currentState.desc,
            withConstraints: .init(
                width: UIScreen.width - Metric.margin.left - Metric.margin.right,
                height: .greatestFiniteMagnitude
            ),
            limitedToNumberOfLines: UInt(Metric.trendingMaxLines)
        ).height
        height += descHeight
        height += Metric.repoStatusHeight
        height += 5
        return CGSize(width: width, height: height.flat)
    }

}

extension RepoCell: SWFLabelDelegate {

    func attributedLabel(_ label: SWFLabel!, didSelectLinkWith result: NSTextCheckingResult!) {
        guard let repo = self.model as? Repo else { return }
        self.usernameSubject.onNext(repo.owner.username)
    }

}
