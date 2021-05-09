//
//  ThemeCell.swift
//  SWHub
//
//  Created by liaoya on 2021/5/8.
//

import UIKit

class ThemeCell: BaseTableCell, ReactorKit.View {
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.size = .init(60)
        imageView.cornerRadius = imageView.width / 2.0
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.iconImageView)
        themeService.rx
            .bind({ $0.titleColor }, to: self.textLabel!.rx.textColor)
            .bind({ $0.primaryColor }, to: self.rx.tintColor)
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
        self.iconImageView.left = 20
        self.iconImageView.top = self.iconImageView.topWhenCenter
        self.textLabel!.left = self.iconImageView.right + 10
        self.textLabel!.top = self.textLabel!.topWhenCenter
    }

    func bind(reactor: ThemeItem) {
        super.bind(item: reactor)
        reactor.state.map { $0.checked }
            .distinctUntilChanged()
            .bind(to: self.rx.checked)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.color }
            .distinctUntilChanged()
            .bind(to: self.iconImageView.rx.backgroundColor)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.name }
            .distinctUntilChanged()
            .bind(to: self.textLabel!.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map { _ in }
            .bind(to: self.rx.setNeedsLayout)
            .disposed(by: self.disposeBag)
    }
    
    override class func height(item: BaseTableItem) -> CGFloat {
        70
    }

}

extension Reactive where Base: ThemeCell {

    var checked: Binder<Bool> {
        return Binder(self.base) { cell, checked in
            cell.accessoryType = checked ? .checkmark : .none
        }
    }

}
