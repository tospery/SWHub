//
//  SummaryUserCell+Rx.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/23.
//

import UIKit

extension Reactive where Base: SummaryUserCell {
    
    var repositories: Binder<NSAttributedString?> {
        self.base.statView.rx.leftAttributedText
    }
    
    var followers: Binder<NSAttributedString?> {
        self.base.statView.rx.centerAttributedText
    }
    
    var following: Binder<NSAttributedString?> {
        self.base.statView.rx.rightAttributedText
    }
    
    var avatar: Binder<ImageSource?> {
        self.base.infoView.avatarImageView.rx.imageResource(placeholder: R.image.default_avatar())
    }
    
    var name: Binder<NSAttributedString?> {
        self.base.infoView.nameLabel.rx.attributedText
    }
    
    var bio: Binder<String?> {
        self.base.infoView.bioLabel.rx.text
    }
    
    var time: Binder<String?> {
        self.base.infoView.timeLabel.rx.text
    }
    
    var indicator: Binder<Bool> {
        self.base.infoView.indicatorImageView.rx.isHidden
    }
    
    var login: ControlEvent<Void> {
        self.base.loginButton.rx.tap
    }

}
