//
//  MineHeaderView.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/1.
//

import UIKit

class MineHeaderView: BaseSupplementaryView {

    var user: User?
    
    lazy var nameLabel: SWLabel = {
        let label = SWLabel.init()
        label.font = .systemFont(ofSize: 19)
        label.sizeToFit()
        return label
    }()
    
    lazy var descLabel: SWLabel = {
        let label = SWLabel.init()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        label.sizeToFit()
        label.qmui_lineHeight = (label.qmui_lineHeight + 2).flat
        return label
    }()
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.sizeToFit()
        imageView.size = .init(80)
        imageView.cornerRadius = imageView.width / 2.0
        return imageView
    }()
    
    lazy var repositoriesButton: SWButton = {
        let button = SWButton.init()
        button.titleLabel?.numberOfLines = 2
        button.sizeToFit()
        return button
    }()
    
    lazy var followersButton: SWButton = {
        let button = SWButton.init()
        button.titleLabel?.numberOfLines = 2
        button.sizeToFit()
        return button
    }()
    
    lazy var followingButton: SWButton = {
        let button = SWButton.init()
        button.titleLabel?.numberOfLines = 2
        button.sizeToFit()
        return button
    }()

    lazy var topView: UIView = {
        let view = UIView()
        view.sizeToFit()
        return view
    }()
    
    lazy var bottomView: UIView = {
        let view = UIView()
        view.qmui_borderPosition = .top
        view.qmui_borderWidth = 1
        view.sizeToFit()
        view.height = 70
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.topView)
        self.addSubview(self.bottomView)
        self.topView.addSubview(self.avatarImageView)
        self.topView.addSubview(self.nameLabel)
        self.topView.addSubview(self.descLabel)
        self.bottomView.addSubview(self.repositoriesButton)
        self.bottomView.addSubview(self.followersButton)
        self.bottomView.addSubview(self.followingButton)
        themeService.rx
            .bind({ $0.borderColor }, to: self.bottomView.rx.qmui_borderColor)
            .bind({ $0.contentColor }, to: self.descLabel.rx.textColor)
            .disposed(by: self.rx.disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.bottomView.width = self.width
        self.bottomView.left = 0
        self.bottomView.bottom = self.height
        self.topView.width = self.width
        self.topView.height = self.height - self.bottomView.height
        self.topView.left = 0
        self.topView.top = 0
        self.followersButton.sizeToFit()
        self.followersButton.left = self.followersButton.leftWhenCenter
        self.followersButton.top = self.followersButton.topWhenCenter
        self.repositoriesButton.sizeToFit()
        self.repositoriesButton.centerX = self.width / 2.0 / 2.0 - 15.f
        self.repositoriesButton.top = self.repositoriesButton.topWhenCenter
        self.followingButton.sizeToFit()
        self.followingButton.centerX = self.width / 2.0 / 2.0 * 3.0 + 15.f
        self.followingButton.top = self.followingButton.topWhenCenter
        self.avatarImageView.left = 30
        self.avatarImageView.top = UINavigationBar.contentHeightConstant + 10
        self.nameLabel.sizeToFit()
        self.nameLabel.left = self.avatarImageView.right + 10
        self.nameLabel.bottom = self.avatarImageView.centerY - 1
        self.descLabel.sizeToFit()
        self.descLabel.left = self.nameLabel.left
        self.descLabel.width = self.topView.width - self.descLabel.left - 10
        self.descLabel.height = self.avatarImageView.bottom - self.nameLabel.bottom - 2
        self.descLabel.top = self.nameLabel.bottom + 2
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.descLabel.text = nil
        self.nameLabel.attributedText = nil
        self.repositoriesButton.setAttributedTitle(nil, for: .normal)
        self.followersButton.setAttributedTitle(nil, for: .normal)
        self.followingButton.setAttributedTitle(nil, for: .normal)
        self.avatarImageView.image = nil
    }

}

extension Reactive where Base: MineHeaderView {

    var user: Binder<User?> {
        return Binder(self.base) { view, user in
            view.user = user
            view.descLabel.text = user?.bio
            view.nameLabel.attributedText = user?.profileName
            view.repositoriesButton.setAttributedTitle(user?.repositoriesAttrString, for: .normal)
            view.followersButton.setAttributedTitle(user?.followersAttrString, for: .normal)
            view.followingButton.setAttributedTitle(user?.followingAttrString, for: .normal)
            view.avatarImageView.kf.setImage(with: user?.avatarUrl?.url)
            view.setNeedsLayout()
        }
    }

//    var pay: ControlEvent<Void> {
//        let source = base.payButton.rx.tap.map { _ in }
//        return ControlEvent(events: source)
//    }

}
