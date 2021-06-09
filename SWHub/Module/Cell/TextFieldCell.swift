//
//  TextFieldCell.swift
//  SWHub
//
//  Created by liaoya on 2021/5/27.
//

import UIKit

class TextFieldCell: BaseCollectionCell, ReactorKit.View {
    
    lazy var textField: UITextField = {
        let textField = UITextField.init()
        textField.font = .normal(16)
        textField.sizeToFit()
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.textField)
        themeService.rx
            .bind({ $0.titleColor }, to: self.textField.rx.textColor)
            .bind({ $0.headerColor }, to: self.textField.rx.placeHolderColor)
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
        self.textField.sizeToFit()
        self.textField.width = self.contentView.width - 20 * 2
        self.textField.height = self.contentView.height
        self.textField.left = self.textField.leftWhenCenter
        self.textField.top = self.textField.topWhenCenter
    }

    func bind(reactor: TextFieldItem) {
        super.bind(item: reactor)
        reactor.state.map { $0.text }
            .distinctUntilChanged()
            .bind(to: self.textField.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map { _ in }
            .bind(to: self.rx.setNeedsLayout)
            .disposed(by: self.disposeBag)
    }
    
    override class func size(width: CGFloat, item: BaseCollectionItem) -> CGSize {
        .init(width: width, height: 44)
    }

}
