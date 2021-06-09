//
//  AppCell.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/23.
//

import UIKit

class AppCell: BaseCollectionCell, ReactorKit.View {
    
    lazy var nameLabel: UILabel = {
        let label = UILabel.init()
        label.text = UIApplication.shared.name
        label.font = .normal(18)
        label.sizeToFit()
        return label
    }()
    
    lazy var versionLabel: UILabel = {
        let label = UILabel.init()
        label.text = "\(UIApplication.shared.version!)(\(UIApplication.shared.buildNumber!))"
        label.font = .normal(14)
        label.sizeToFit()
        return label
    }()
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.appLogo()
        imageView.sizeToFit()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.versionLabel)
        self.contentView.addSubview(self.iconImageView)
        themeService.rx
            .bind({ $0.brightColor }, to: self.contentView.rx.backgroundColor)
            .bind({ $0.titleColor }, to: self.nameLabel.rx.textColor)
            .bind({ $0.footerColor }, to: self.versionLabel.rx.textColor)
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
        self.iconImageView.left = self.iconImageView.leftWhenCenter
        self.iconImageView.top = self.iconImageView.topWhenCenter * 0.6
        self.nameLabel.left = self.nameLabel.leftWhenCenter
        self.nameLabel.top = self.iconImageView.bottom + 10
        self.versionLabel.left = self.versionLabel.leftWhenCenter
        self.versionLabel.top = self.nameLabel.bottom
    }

    func bind(reactor: AppItem) {
        super.bind(item: reactor)
        reactor.state.map { _ in }
            .bind(to: self.rx.setNeedsLayout)
            .disposed(by: self.disposeBag)
    }
    
    override class func size(width: CGFloat, item: BaseCollectionItem) -> CGSize {
        .init(width: width, height: metric(200))
    }

}
