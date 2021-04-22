//
//  CollectionCell.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import UIKit

class CollectionCell: SWFrame.BaseCollectionCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        themeService.rx
            .bind({ $0.backgroundColor }, to: self.contentView.rx.backgroundColor)
            .disposed(by: self.rx.disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
