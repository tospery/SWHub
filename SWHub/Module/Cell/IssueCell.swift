//
//  IssueCell.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/3.
//

import UIKit

class IssueCell: BaseCollectionCell, ReactorKit.View {
    
    lazy var usernameLabel: SWLabel = {
        let label = SWLabel()
        label.font = .systemFont(ofSize: 17)
        label.sizeToFit()
        return label
    }()
    
    lazy var timeLabel: SWLabel = {
        let label = SWLabel()
        label.font = .systemFont(ofSize: 14)
        label.sizeToFit()
        return label
    }()
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.sizeToFit()
        imageView.size = .init(32)
        imageView.cornerRadius = imageView.width / 2.f
        return imageView
    }()
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.cornerRadius = 4
        imageView.sizeToFit()
        imageView.size = .init(20)
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.qmui_borderWidth = 1
        self.contentView.qmui_borderPosition = .bottom

        self.contentView.addSubview(self.usernameLabel)
        self.contentView.addSubview(self.avatarImageView)
        self.contentView.addSubview(self.iconImageView)
        self.contentView.addSubview(self.timeLabel)

        themeService.rx
            .bind({ $0.titleColor }, to: self.usernameLabel.rx.textColor)
            .bind({ $0.footerColor }, to: self.timeLabel.rx.textColor)
            .disposed(by: self.rx.disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.usernameLabel.text = nil
        self.timeLabel.text = nil
        self.avatarImageView.image = nil
        self.iconImageView.image = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.avatarImageView.left = 10
        self.avatarImageView.top = 5
        self.iconImageView.right = self.contentView.width
        self.iconImageView.top = 0
        self.usernameLabel.sizeToFit()
        self.usernameLabel.width = self.iconImageView.left - 10 - self.avatarImageView.right - 10
        self.usernameLabel.left = self.avatarImageView.right + 10
        self.usernameLabel.centerY = self.avatarImageView.centerY
        self.timeLabel.sizeToFit()
        self.timeLabel.left = 10
        self.timeLabel.bottom = self.contentView.height - 5
    }

    func bind(reactor: IssueItem) {
        super.bind(item: reactor)
        reactor.state.map { $0.username }
            .distinctUntilChanged()
            .bind(to: self.usernameLabel.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.time }
            .distinctUntilChanged()
            .bind(to: self.timeLabel.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.avatar }
            .distinctUntilChanged { SWHub.compare($0, $1) }
            .bind(to: self.avatarImageView.rx.imageSource)
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
        .init(width: width, height: 100)
    }

}
