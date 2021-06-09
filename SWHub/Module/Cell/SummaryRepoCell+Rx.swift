//
//  SummaryRepoCell+Rx.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/31.
//

import UIKit

extension Reactive where Base: SummaryRepoCell {
    
    var watches: Binder<NSAttributedString?> {
        self.base.statView.rx.leftAttributedText
    }
    
    var stars: Binder<NSAttributedString?> {
        self.base.statView.rx.centerAttributedText
    }
    
    var forks: Binder<NSAttributedString?> {
        self.base.statView.rx.rightAttributedText
    }
    
    var name: Binder<String?> {
        self.base.infoView.nameLabel.rx.text
    }
    
    var desc: Binder<NSAttributedString?> {
        self.base.infoView.descLabel.rx.attributedText
    }
    
    var time: Binder<String?> {
        self.base.infoView.timeLabel.rx.text
    }

}
