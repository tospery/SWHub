//
//  ButtonCell.swift
//  SWHub
//
//  Created by liaoya on 2021/5/27.
//

import UIKit

class ButtonCell: BaseCollectionCell, ReactorKit.View {
    
    lazy var button: UIButton = {
        let button = UIButton.init(type: .custom)
        button.cornerRadius = 4
        button.titleLabel?.font = .normal(17)
        button.sizeToFit()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.button)
        themeService.rx
            .bind({ $0.backgroundColor }, to: self.button.rx.titleColor(for: .normal))
            .bind({
                UIImage.init(color: $0.primaryColor, size: frame.size)
            }, to: self.button.rx.backgroundImage(for: .normal))
            .bind({
                UIImage.init(color: $0.primaryColor.withAlphaComponent(0.8), size: frame.size)
            }, to: self.button.rx.backgroundImage(for: .highlighted))
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
        self.button.sizeToFit()
        self.button.width = self.contentView.width - 20 * 2
        self.button.height = self.contentView.height
        self.button.left = self.button.leftWhenCenter
        self.button.top = self.button.topWhenCenter
    }

    func bind(reactor: ButtonItem) {
        super.bind(item: reactor)
        reactor.state.map { $0.text }
            .distinctUntilChanged()
            .bind(to: self.button.rx.title(for: .normal))
            .disposed(by: self.disposeBag)
        reactor.state.map { _ in }
            .bind(to: self.rx.setNeedsLayout)
            .disposed(by: self.disposeBag)
    }
    
    override class func size(width: CGFloat, item: BaseCollectionItem) -> CGSize {
        .init(width: width, height: 44)
    }

}
