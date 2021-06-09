//
//  TrendingUserCell+Rx.swift
//  SWHub
//
//  Created by liaoya on 2021/6/1.
//

import UIKit

extension Reactive where Base: TrendingUserCell {
    
    var ranking: Binder<String?> {
        self.base.rankingLabel.rx.text
    }
    
    var username: Binder<NSAttributedString?> {
        self.base.usernameLabel.rx.attributedText
    }
    
    var reponame: Binder<NSAttributedString?> {
        self.base.reponameLabel.rx.attributedText
    }
    
    var repodesc: Binder<NSAttributedString?> {
        self.base.repodescLabel.rx.attributedText
    }
    
    var avatar: Binder<ImageSource?> {
        self.base.avatarImageView.rx.imageResource(placeholder: R.image.default_avatar())
    }
    
}
