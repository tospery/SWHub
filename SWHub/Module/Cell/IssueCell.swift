//
//  IssueCell.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/3.
//

import UIKit
import TTGTagCollectionView

class IssueCell: BaseCollectionCell, ReactorKit.View {
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.sizeToFit()
        imageView.size = .init(32)
        return imageView
    }()
    
    lazy var titleLabel: SWFLabel = {
        let label = SWFLabel.init(frame: .zero)
        label.numberOfLines = 2
        label.font = .normal(16)
        label.qmui_lineHeight = label.font.lineHeight.flat
        label.sizeToFit()
        label.height = label.qmui_lineHeight * 2
        return label
    }()
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.cornerRadius = 5
        imageView.sizeToFit()
        imageView.size = .init(18)
        return imageView
    }()
    
    lazy var usernameLabel: SWFLabel = {
        let label = SWFLabel.init(frame: .zero)
        label.font = .normal(14)
        label.sizeToFit()
        return label
    }()

    lazy var commentsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.issue_comment()
        imageView.sizeToFit()
        return imageView
    }()
    
    lazy var commentsLabel: SWFLabel = {
        let label = SWFLabel.init(frame: .zero)
        label.textAlignment = .left
        label.font = .normal(12)
        label.sizeToFit()
        label.size = .init(width: 20, height: label.font.lineHeight.flat)
        return label
    }()
    
    lazy var timeLabel: SWFLabel = {
        let label = SWFLabel.init(frame: .zero)
        label.textAlignment = .right
        label.font = .normal(12)
        label.sizeToFit()
        return label
    }()
    
    lazy var tagsView: TTGTextTagCollectionView = {
        let view = TTGTextTagCollectionView.init()
        view.numberOfLines = 1
        view.contentInset = .init(top: 4, left: 2, bottom: 2, right: 2)
        view.sizeToFit()
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.qmui_borderWidth = 1
        self.contentView.qmui_borderPosition = .bottom

        self.contentView.addSubview(self.iconImageView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.avatarImageView)
        self.contentView.addSubview(self.usernameLabel)
        self.contentView.addSubview(self.commentsImageView)
        self.contentView.addSubview(self.commentsLabel)
        self.contentView.addSubview(self.timeLabel)
        self.contentView.addSubview(self.tagsView)
        
        themeService.rx
            .bind({ $0.primaryColor }, to: self.titleLabel.rx.textColor)
            .bind({ $0.titleColor }, to: self.usernameLabel.rx.textColor)
            .bind({ $0.bodyColor }, to: [
                self.commentsLabel.rx.textColor,
                self.timeLabel.rx.textColor
            ])
            .bind({ $0.borderColor }, to: self.contentView.rx.qmui_borderColor)
            .disposed(by: self.rx.disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.iconImageView.image = nil
        self.titleLabel.text = nil
        self.avatarImageView.image = nil
        self.usernameLabel.text = nil
        self.commentsLabel.text = nil
        self.timeLabel.text = nil
        self.tagsView.removeAllTags()
        self.tagsView.reload()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.iconImageView.left = 15
        self.iconImageView.top = 10
        self.titleLabel.left = self.iconImageView.right + 10
        self.titleLabel.extendToRight = self.contentView.width - 15
        self.titleLabel.centerY = self.iconImageView.centerY
        self.avatarImageView.centerX = self.iconImageView.centerX
        self.avatarImageView.bottom = self.contentView.height - 10
        self.usernameLabel.sizeToFit()
        self.usernameLabel.left = self.avatarImageView.right + 5
        self.usernameLabel.centerY = self.avatarImageView.centerY
        self.commentsLabel.right = self.titleLabel.right
        self.commentsLabel.centerY = self.avatarImageView.centerY
        self.commentsImageView.right = self.commentsLabel.left - 5
        self.commentsImageView.centerY = self.avatarImageView.centerY
        self.timeLabel.sizeToFit()
        self.timeLabel.right = self.commentsImageView.left - 10
        self.timeLabel.centerY = self.avatarImageView.centerY
        self.tagsView.width = self.contentView.width - 30
        self.tagsView.height = self.avatarImageView.top - self.iconImageView.bottom
        self.tagsView.left = self.iconImageView.left
        self.tagsView.top = self.iconImageView.bottom
    }

    func bind(reactor: IssueItem) {
        super.bind(item: reactor)
        reactor.state.map { $0.icon }
            .distinctUntilChanged { SWFrame.compareImage($0, $1) }
            .bind(to: self.iconImageView.rx.imageResource(placeholder: R.image.default_avatar()))
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.title }
            .distinctUntilChanged()
            .bind(to: self.titleLabel.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.avatar }
            .distinctUntilChanged { SWFrame.compareImage($0, $1) }
            .bind(to: self.avatarImageView.rx.imageSource)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.username }
            .distinctUntilChanged()
            .bind(to: self.usernameLabel.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.comments.string }
            .distinctUntilChanged()
            .bind(to: self.commentsLabel.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.time }
            .distinctUntilChanged()
            .bind(to: self.timeLabel.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.labels }
            .distinctUntilChanged()
            .bind(to: self.rx.labels)
            .disposed(by: self.disposeBag)
        reactor.state.map { _ in }
            .bind(to: self.rx.setNeedsLayout)
            .disposed(by: self.disposeBag)
    }

    override class func size(width: CGFloat, item: BaseCollectionItem) -> CGSize {
        var height = 80.f
        if (item as? IssueItem)?.currentState.labels.count ?? 0 != 0 {
            height += 20
        }
        return .init(width: width, height: height)
    }

}
