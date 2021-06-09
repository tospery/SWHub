//
//  SummaryUserCell.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/23.
//

import UIKit

class SummaryUserCell: BaseCollectionCell, ReactorKit.View {
    
    lazy var infoView: UserInfoView = {
        let view = UserInfoView.init()
        view.sizeToFit()
        return view
    }()
    
    lazy var statView: StatView = {
        let view = StatView.init()
        view.sizeToFit()
        return view
    }()
    
    lazy var emptyView: UIView = {
        let view = UIView.init()
        view.isHidden = true
        view.sizeToFit()
        return view
    }()
    
    lazy var loginButton: SWFButton = {
        let button = SWFButton.init(type: .custom)
        button.imagePosition = .top
        button.spacingBetweenImageAndTitle = 8
        button.titleLabel?.font = .normal(17)
        button.setTitle(R.string.localizable.loginClickToLogin(), for: .normal)
        button.setImage(R.image.user_empty()?.template, for: .normal)
        button.sizeToFit()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.statView)
        self.contentView.addSubview(self.infoView)
        self.contentView.addSubview(self.emptyView)
        self.emptyView.addSubview(self.loginButton)
        themeService.rx
            .bind({ $0.backgroundColor }, to: self.emptyView.rx.backgroundColor)
            .bind({ $0.titleColor }, to: self.loginButton.rx.titleColor(for: .normal))
            .bind({ $0.primaryColor }, to: self.loginButton.rx.tintColor)
            .disposed(by: self.rx.disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.statView.leftButton.setAttributedTitle(nil, for: .normal)
        self.statView.centerButton.setAttributedTitle(nil, for: .normal)
        self.statView.rightButton.setAttributedTitle(nil, for: .normal)
        self.infoView.avatarImageView.image = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.statView.height = (self.contentView.height * 0.38).flat
        self.statView.width = self.contentView.width
        self.statView.left = 0
        self.statView.bottom = self.contentView.height
        self.infoView.width = self.statView.width
        self.infoView.height = self.contentView.height - self.statView.height
        self.infoView.left = 0
        self.infoView.top = 0
        self.emptyView.frame = self.contentView.bounds
        self.loginButton.left = self.loginButton.leftWhenCenter
        self.loginButton.top = self.loginButton.topWhenCenter
    }

    // swiftlint:disable function_body_length
    func bind(reactor: SummaryUserItem) {
        super.bind(item: reactor)
        self.bindParentIfNeed(reactor)
        reactor.state.map { $0.isLogined }
            .distinctUntilChanged()
            .bind(to: self.emptyView.rx.isHidden)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.name }
            .distinctUntilChanged()
            .bind(to: self.rx.name)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.bio }
            .distinctUntilChanged()
            .bind(to: self.rx.bio)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.time }
            .distinctUntilChanged()
            .bind(to: self.rx.time)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.repositories }
            .distinctUntilChanged()
            .bind(to: self.rx.repositories)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.followers }
            .distinctUntilChanged()
            .bind(to: self.rx.followers)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.following }
            .distinctUntilChanged()
            .bind(to: self.rx.following)
            .disposed(by: self.disposeBag)
        reactor.state.map { !$0.isIndicated }
            .distinctUntilChanged()
            .bind(to: self.rx.indicator)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.avatar?.url }
            .distinctUntilChanged { SWFrame.compareImage($0, $1) }
            .bind(to: self.rx.avatar)
            .disposed(by: self.disposeBag)
        reactor.state.map { _ in }
            .bind(to: self.rx.setNeedsLayout)
            .disposed(by: self.disposeBag)
    }
    
    func bindParentIfNeed(_ reactor: SummaryUserItem) {
        guard let parent = reactor.parent as? ListViewReactor else { return }
        parent.state.map { $0.user?.isValid ?? false }
            .distinctUntilChanged()
            .map { Reactor.Action.logined($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        parent.state.map { $0.user?.nameStyle }
            .distinctUntilChanged()
            .map { Reactor.Action.name($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        parent.state.map { $0.user?.bio ?? R.string.localizable.noneDesc() }
            .distinctUntilChanged()
            .map { Reactor.Action.bio($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        parent.state.map { $0.user?.joinedStyle }
            .distinctUntilChanged()
            .map { Reactor.Action.time($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        parent.state.map { $0.user?.repositoriesStyle }
            .distinctUntilChanged()
            .map { Reactor.Action.repositories($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        parent.state.map { $0.user?.followersStyle }
            .distinctUntilChanged()
            .map { Reactor.Action.followers($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        parent.state.map { $0.user?.followingStyle }
            .distinctUntilChanged()
            .map { Reactor.Action.following($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        parent.state.map { $0.user?.avatar }
            .distinctUntilChanged()
            .map { Reactor.Action.avatar($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
    // swiftlint:enable function_body_length
    
    override class func size(width: CGFloat, item: BaseCollectionItem) -> CGSize {
        .init(width: width, height: 170)
    }

}
