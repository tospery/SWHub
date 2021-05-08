//
//  ThemeCell.swift
//  SWHub
//
//  Created by liaoya on 2021/5/8.
//

import UIKit

class ThemeCell: BaseTableCell, ReactorKit.View {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .random
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

    func bind(reactor: ThemeItem) {
        super.bind(item: reactor)
//        reactor.state.map { $0.username }
//            .distinctUntilChanged()
//            .bind(to: self.usernameLabel.rx.text)
//            .disposed(by: self.disposeBag)
//        reactor.state.map { $0.time }
//            .distinctUntilChanged()
//            .bind(to: self.timeLabel.rx.text)
//            .disposed(by: self.disposeBag)
//        reactor.state.map { $0.comments }
//            .distinctUntilChanged()
//            .bind(to: self.commentsLabel.rx.text)
//            .disposed(by: self.disposeBag)
//        reactor.state.map { $0.title }
//            .distinctUntilChanged()
//            .bind(to: self.titleLabel.rx.text)
//            .disposed(by: self.disposeBag)
//        reactor.state.map { $0.avatar }
//            .distinctUntilChanged { SWHub.compare($0, $1) }
//            .bind(to: self.avatarImageView.rx.imageSource)
//            .disposed(by: self.disposeBag)
//        reactor.state.map { $0.icon }
//            .distinctUntilChanged { SWHub.compare($0, $1) }
//            .bind(to: self.iconImageView.rx.imageSource)
//            .disposed(by: self.disposeBag)
        reactor.state.map { _ in }
            .bind(to: self.rx.setNeedsLayout)
            .disposed(by: self.disposeBag)
    }
    
    override class func height(item: BaseTableItem) -> CGFloat {
        50
    }

}
