//
//  EmptyCell.swift
//  SWHub
//
//  Created by liaoya on 2021/5/27.
//

import UIKit

class EmptyCell: BaseCollectionCell, ReactorKit.View {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func bind(reactor: EmptyItem) {
        super.bind(item: reactor)
        reactor.state.map { _ in }
            .bind(to: self.rx.setNeedsLayout)
            .disposed(by: self.disposeBag)
    }
    
    override class func size(width: CGFloat, item: BaseCollectionItem) -> CGSize {
        .zero
    }

}
