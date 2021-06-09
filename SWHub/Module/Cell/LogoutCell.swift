//
//  LogoutCell.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/25.
//

import UIKit

class LogoutCell: BaseCollectionCell, ReactorKit.View {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel.init()
        label.font = .normal(15)
        label.text = R.string.localizable.userLogout()
        label.sizeToFit()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.titleLabel)

        themeService.rx
            .bind({ $0.primaryColor }, to: self.titleLabel.rx.textColor)
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
        self.titleLabel.sizeToFit()
        self.titleLabel.left = self.titleLabel.leftWhenCenter
        self.titleLabel.top = self.titleLabel.topWhenCenter
    }

    func bind(reactor: LogoutItem) {
        super.bind(item: reactor)
        reactor.state.map { _ in }
            .bind(to: self.rx.setNeedsLayout)
            .disposed(by: self.disposeBag)
    }
    
    override class func size(width: CGFloat, item: BaseCollectionItem) -> CGSize {
        .init(width: width, height: 50)
    }

}
