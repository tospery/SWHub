//
//  SummaryRepoCell.swift
//  SWHub
//
//  Created by liaoya on 2021/5/31.
//

import UIKit

class SummaryRepoCell: BaseCollectionCell, ReactorKit.View {
    
    lazy var infoView: RepoInfoView = {
        let view = RepoInfoView.init()
        view.sizeToFit()
        return view
    }()
    
    lazy var statView: StatView = {
        let view = StatView.init()
        view.sizeToFit()
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.statView)
        self.contentView.addSubview(self.infoView)
        themeService.rx
            .bind({ $0.brightColor }, to: self.contentView.rx.backgroundColor)
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
        self.statView.width = self.contentView.width
        self.statView.height = StatView.Metric.height
        self.statView.left = 0
        self.statView.bottom = self.contentView.height
        self.infoView.width = self.contentView.width
        self.infoView.height = self.statView.top
        self.infoView.left = 0
        self.infoView.top = 0
    }

    func bind(reactor: SummaryRepoItem) {
        super.bind(item: reactor)
        self.bindParentIfNeed(reactor)
        reactor.state.map { $0.name }
            .distinctUntilChanged()
            .bind(to: self.rx.name)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.time }
            .distinctUntilChanged()
            .bind(to: self.infoView.timeLabel.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.bio }
            .distinctUntilChanged()
            .bind(to: self.rx.bio)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.watches }
            .distinctUntilChanged()
            .bind(to: self.rx.watches)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.stars }
            .distinctUntilChanged()
            .bind(to: self.rx.stars)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.forks }
            .distinctUntilChanged()
            .bind(to: self.rx.forks)
            .disposed(by: self.disposeBag)
        reactor.state.map { _ in }
            .bind(to: self.rx.setNeedsLayout)
            .disposed(by: self.disposeBag)
    }

    func bindParentIfNeed(_ reactor: SummaryRepoItem) {
        guard let parent = reactor.parent as? ListViewReactor else { return }
        parent.state.map { $0.repo?.descAttributedText }
            .distinctUntilChanged()
            .map { Reactor.Action.bio($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        parent.state.map { $0.repo?.updateAgo }
            .distinctUntilChanged()
            .map { Reactor.Action.time($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        parent.state.map { $0.repo?.watchesAttributedText }
            .distinctUntilChanged()
            .map { Reactor.Action.watches($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        parent.state.map { $0.repo?.starsStyle2 }
            .distinctUntilChanged()
            .map { Reactor.Action.stars($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        parent.state.map { $0.repo?.forksAttributedText }
            .distinctUntilChanged()
            .map { Reactor.Action.forks($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
    
    override class func size(width: CGFloat, item: BaseCollectionItem) -> CGSize {
        guard let repo = item.model as? Repo  else { return .zero }
        let height = UILabel.size(
            attributedString: repo.descAttributedText,
            withConstraints: .init(width: width - 20 * 2, height: .greatestFiniteMagnitude),
            limitedToNumberOfLines: 5
        ).height
        return CGSize(width: width, height: (118 + height + 5).flat)
    }

}
