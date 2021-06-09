//
//  SinceCell.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/20.
//

import UIKit

class SinceCell: BaseCollectionCell, ReactorKit.View {
    
    lazy var button: UIButton = {
        let button = UIButton.init(type: .custom)
        button.titleLabel?.font = .normal(13)
        button.sizeToFit()
        button.size = .init(width: 85, height: 30)
        button.cornerRadius = button.height / 2.f
        return button
    }()

    // f8eded
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.button)
        let size = self.button.size
        themeService.rx
            .bind({ $0.titleColor }, to: self.button.rx.titleColor(for: .normal))
            .bind({ $0.primaryColor }, to: self.button.rx.titleColor(for: .selected))
            .bind({ UIImage.init(color: $0.brightColor, size: size) },
                  to: self.button.rx.backgroundImage(for: .normal))
            .bind({ UIImage.init(color: $0.primaryColor.withAlphaComponent(0.2), size: size) },
                  to: self.button.rx.backgroundImage(for: .selected))
            .disposed(by: self.rx.disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.button.isSelected = false
        self.button.setTitle(nil, for: .normal)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.button.left = self.button.leftWhenCenter
        self.button.top = self.button.topWhenCenter
    }

    func bind(reactor: SinceItem) {
        super.bind(item: reactor)
        reactor.state.map { $0.name }
            .distinctUntilChanged()
            .bind(to: self.button.rx.title())
            .disposed(by: self.disposeBag)
        reactor.state.map { _ in }
            .bind(to: self.rx.setNeedsLayout)
            .disposed(by: self.disposeBag)
    }

    override class func size(width: CGFloat, item: BaseCollectionItem) -> CGSize {
        .init(width: (width / 3.f).floorInPixel, height: 50)
    }

}
