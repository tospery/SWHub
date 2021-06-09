//
//  UserInfoView.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/23.
//

import UIKit

class UserInfoView: BaseView {
    
    lazy var nameLabel: UILabel = {
        let label = UILabel.init()
        label.sizeToFit()
        label.height = 21
        return label
    }()
    
    lazy var bioLabel: UILabel = {
        let label = UILabel.init()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .normal(15)
        label.sizeToFit()
        label.height = (label.font.lineHeight + 1).flat
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel.init()
        label.font = .normal(13)
        label.sizeToFit()
        label.height = 16
        return label
    }()
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.cornerRadius = 8
        imageView.sizeToFit()
        return imageView
    }()
    
    lazy var indicatorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.indicator.template
        imageView.sizeToFit()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.avatarImageView)
        self.addSubview(self.indicatorImageView)
        self.addSubview(self.nameLabel)
        self.addSubview(self.bioLabel)
        self.addSubview(self.timeLabel)
        themeService.rx
            .bind({ $0.primaryColor }, to: self.indicatorImageView.rx.tintColor)
            .bind({ $0.bodyColor }, to: self.bioLabel.rx.textColor)
            .bind({ $0.foregroundColor }, to: self.timeLabel.rx.textColor)
            .disposed(by: self.rx.disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let height = (self.height * 0.7).flat
        self.avatarImageView.size = .init(height)
        self.avatarImageView.left = 20
        self.avatarImageView.top = self.avatarImageView.topWhenCenter
        self.indicatorImageView.right = self.width - 10
        self.indicatorImageView.top = self.indicatorImageView.topWhenCenter
        let width = self.indicatorImageView.left - 5 - self.avatarImageView.right - 10
        self.bioLabel.width = width
        self.bioLabel.left = self.avatarImageView.right + 10
        self.bioLabel.top = (self.bioLabel.topWhenCenter * 1.1).flat
        self.timeLabel.width = width
        self.timeLabel.left = self.bioLabel.left
        self.timeLabel.top = self.bioLabel.bottom + metric(2)
        self.nameLabel.width = width
        self.nameLabel.left = self.bioLabel.left
        self.nameLabel.bottom = self.bioLabel.top - metric(2)
    }
    
}
