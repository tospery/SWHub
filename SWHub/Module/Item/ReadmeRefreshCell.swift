//
//  ReadmeRefreshCell.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/17.
//

import UIKit

class ReadmeRefreshCell: BaseCollectionCell, ReactorKit.View {

    lazy var titleLabel: SWFLabel = {
        let label = SWFLabel.init(frame: .zero)
        label.font = .normal(16)
        label.sizeToFit()
        return label
    }()

    lazy var detailButton: SWFButton = {
        let button = SWFButton.init(type: .custom)
        button.setImage(R.image.refresh(), for: .normal)
        button.sizeToFit()
        return button
    }()

    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.sizeToFit()
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.borderLayer?.borders = .bottom
        self.borderLayer?.borderColors = [BorderLayer.Border.bottom: UIColor.border]
        self.borderLayer?.borderWidths = [BorderLayer.Border.bottom: pixelOne]
        self.borderLayer?.borderInsets = [BorderLayer.Border.bottom: (15, 0)]

        self.contentView.addSubview(self.iconImageView)
        self.contentView.addSubview(self.titleLabel)
        // self.contentView.addSubview(self.detailButton)

        themeService.rx
            .bind({ $0.titleColor }, to: self.titleLabel.rx.textColor)
            .bind({ $0.primaryColor }, to: self.iconImageView.rx.tintColor)
            .disposed(by: self.rx.disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override class var layerClass: AnyClass {
        return BorderLayer.self
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        self.layer.frame.size = self.bounds.size
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = nil
        self.iconImageView.image = nil
        self.detailButton.setImage(nil, for: .normal)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.iconImageView.sizeToFit()
        self.iconImageView.left = 15
        self.iconImageView.top = self.iconImageView.topWhenCenter

        self.titleLabel.sizeToFit()
        self.titleLabel.left = self.iconImageView.right + 10
        self.titleLabel.top = self.titleLabel.topWhenCenter

        self.detailButton.sizeToFit()
        self.detailButton.right = self.contentView.width - 20
        self.detailButton.top = self.detailButton.topWhenCenter
    }

    func bind(reactor: ReadmeRefreshItem) {
        super.bind(item: reactor)
        reactor.state.map { $0.title }
            .distinctUntilChanged()
            .bind(to: self.titleLabel.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.icon }
            .distinctUntilChanged { SWFrame.compareImage($0, $1) }
            .bind(to: self.iconImageView.rx.imageResource(placeholder: R.image.default_avatar()))
            .disposed(by: self.disposeBag)
        reactor.state.map { _ in }
            .bind(to: self.rx.setNeedsLayout)
            .disposed(by: self.disposeBag)
    }

    override class func size(width: CGFloat, item: BaseCollectionItem) -> CGSize {
        return CGSize(width: width, height: 50)
    }

}
