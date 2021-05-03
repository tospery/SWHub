//
//  UserCell.swift
//  SWHub
//
//  Created by liaoya on 2021/4/27.
//

import UIKit

class UserCell: BaseCollectionCell, ReactorKit.View {

    struct Metric {
        static let cellHeight = 105.f
    }
    
    lazy var usernameLabel: SWLabel = {
        let label = SWLabel()
        label.font = .systemFont(ofSize: 17)
        label.sizeToFit()
        return label
    }()
    
    lazy var reponameLabel: SWLabel = {
        let label = SWLabel()
        label.sizeToFit()
        return label
    }()
    
    lazy var rankingLabel: SWLabel = {
        let label = SWLabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 11)
        label.sizeToFit()
        label.size = .init(16)
        return label
    }()
    
    lazy var repodescLabel: SWLabel = {
        let label = SWLabel()
        label.numberOfLines = 2
        label.sizeToFit()
        return label
    }()
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.cornerRadius = 8
        imageView.sizeToFit()
        imageView.size = .init((Metric.cellHeight - 30.f).flat)
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.qmui_borderWidth = 1
        self.contentView.qmui_borderPosition = .bottom

        self.contentView.addSubview(self.avatarImageView)
        self.contentView.addSubview(self.usernameLabel)
        self.contentView.addSubview(self.reponameLabel)
        self.contentView.addSubview(self.repodescLabel)
        
        self.avatarImageView.addSubview(self.rankingLabel)

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
        self.usernameLabel.text = nil
        self.reponameLabel.attributedText = nil
        self.repodescLabel.attributedText = nil
        self.avatarImageView.image = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.avatarImageView.left = 15
        self.avatarImageView.top = self.avatarImageView.topWhenCenter
        self.rankingLabel.right = self.avatarImageView.width
        self.rankingLabel.top = 0
        self.usernameLabel.sizeToFit()
        self.usernameLabel.left = self.avatarImageView.right + 10
        self.usernameLabel.top = self.avatarImageView.top
        self.reponameLabel.sizeToFit()
        self.reponameLabel.width = self.contentView.width - self.usernameLabel.left
        self.reponameLabel.left = self.usernameLabel.left
        self.reponameLabel.top = self.usernameLabel.bottom + 2
        self.repodescLabel.sizeToFit()
        self.repodescLabel.left = self.usernameLabel.left
        self.repodescLabel.width = self.contentView.width - self.repodescLabel.left - 10
        self.repodescLabel.height = self.avatarImageView.bottom - self.reponameLabel.bottom - 2
        self.repodescLabel.top = self.reponameLabel.bottom + 2
    }

    func bind(reactor: UserItem) {
        super.bind(item: reactor)
        reactor.state.map { ($0.ranking + 1).string }
            .distinctUntilChanged()
            .bind(to: self.rankingLabel.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.username }
            .distinctUntilChanged()
            .bind(to: self.usernameLabel.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.reponame }
            .distinctUntilChanged()
            .bind(to: self.reponameLabel.rx.attributedText)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.repodesc }
            .distinctUntilChanged()
            .bind(to: self.repodescLabel.rx.attributedText)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.avatar }
            .distinctUntilChanged { SWHub.compare($0, $1) }
            .bind(to: self.avatarImageView.rx.imageSource)
            .disposed(by: self.disposeBag)
        reactor.state.map { _ in }
            .bind(to: self.rx.setNeedsLayout)
            .disposed(by: self.disposeBag)
    }

    override class func size(width: CGFloat, item: BaseCollectionItem) -> CGSize {
        .init(width: width, height: Metric.cellHeight)
    }

}
