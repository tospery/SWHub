//
//  SearchUserCell.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/6/5.
//

import UIKit

class SearchUserCell: BaseCollectionCell, ReactorKit.View {
    
    lazy var nameLabel: UILabel = {
        let label = UILabel.init()
        label.font = .normal(18)
        label.sizeToFit()
        return label
    }()
    
    lazy var urlLabel: UILabel = {
        let label = UILabel.init()
        label.font = .normal(15)
        label.sizeToFit()
        return label
    }()
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.cornerRadius = 4
        imageView.sizeToFit()
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.qmui_borderWidth = pixelOne
        self.contentView.qmui_borderPosition = .bottom

        self.contentView.addSubview(self.avatarImageView)
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.urlLabel)

        themeService.rx
            .bind({ $0.borderColor }, to: self.contentView.rx.qmui_borderColor)
            .bind({ $0.primaryColor }, to: self.nameLabel.rx.textColor)
            .bind({ $0.titleColor }, to: self.urlLabel.rx.textColor)
            .disposed(by: self.rx.disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.nameLabel.text = nil
        self.urlLabel.text = nil
        self.avatarImageView.image = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.avatarImageView.size = .init((self.contentView.height * 0.75).flat)
        self.avatarImageView.left = 10
        self.avatarImageView.top = self.avatarImageView.topWhenCenter
        self.nameLabel.sizeToFit()
        self.nameLabel.left = self.avatarImageView.right + 10
        self.nameLabel.bottom = self.avatarImageView.centerY
        self.nameLabel.extendToRight = self.contentView.width - 10
        self.urlLabel.sizeToFit()
        self.urlLabel.left = self.nameLabel.left
        self.urlLabel.top = self.avatarImageView.centerY + 2
    }

    func bind(reactor: SearchUserItem) {
        super.bind(item: reactor)
        reactor.state.map { $0.avatar }
            .distinctUntilChanged { SWFrame.compareImage($0, $1) }
            .bind(to: self.avatarImageView.rx.imageSource)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.name }
            .distinctUntilChanged()
            .bind(to: self.nameLabel.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.url }
            .distinctUntilChanged()
            .bind(to: self.urlLabel.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map { _ in }
            .bind(to: self.rx.setNeedsLayout)
            .disposed(by: self.disposeBag)
    }

    override class func size(width: CGFloat, item: BaseCollectionItem) -> CGSize {
        .init(width: width, height: 70)
    }

}
