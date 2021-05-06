//
//  AboutHeaderView.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/6.
//

import UIKit

class AboutHeaderView: BaseSupplementaryView {
    
    lazy var nameLabel: SWLabel = {
        let label = SWLabel.init()
        label.text = UIApplication.shared.name
        label.font = .systemFont(ofSize: 18)
        label.sizeToFit()
        return label
    }()
    
    lazy var versionLabel: SWLabel = {
        let label = SWLabel.init()
        label.text = "\(UIApplication.shared.version!)(\(UIApplication.shared.buildNumber!))"
        label.font = .systemFont(ofSize: 14)
        label.sizeToFit()
        return label
    }()
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.app_icon()
        imageView.sizeToFit()
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.nameLabel)
        self.addSubview(self.versionLabel)
        self.addSubview(self.iconImageView)
        themeService.rx
            .bind({ $0.brightColor }, to: self.rx.backgroundColor)
            .bind({ $0.titleColor }, to: self.nameLabel.rx.textColor)
            .bind({ $0.footerColor }, to: self.versionLabel.rx.textColor)
            .disposed(by: self.rx.disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

    override func prepareForReuse() {
        super.prepareForReuse()
        self.nameLabel.text = nil
        self.versionLabel.text = nil
        self.iconImageView.image = nil
    }

}
