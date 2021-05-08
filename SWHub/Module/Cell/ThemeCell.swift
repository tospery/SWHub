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
        // self.imageView?.cornerRadius = 20
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.size = .init(40)
        self.imageView?.left = 20
        self.imageView?.top = self.imageView!.topWhenCenter
        self.textLabel!.left = self.imageView!.right
        self.textLabel?.top = self.textLabel!.topWhenCenter
    }

    func bind(reactor: ThemeItem) {
        super.bind(item: reactor)
        reactor.state.map { $0.color }
            .distinctUntilChanged()
            .bind(to: self.imageView!.rx.tintColor)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.name }
            .distinctUntilChanged()
            .bind(to: self.textLabel!.rx.text)
            .disposed(by: self.disposeBag)
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
