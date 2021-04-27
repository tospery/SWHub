//
//  UserCell.swift
//  SWHub
//
//  Created by liaoya on 2021/4/27.
//

import UIKit

class UserCell: CollectionCell, ReactorKit.View {

    struct Metric {
        static let cellHeight = 80.f
        static let avatarSize = CGSize.init(24)
        static let rankingSize = CGSize.init(20)
    }
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.cornerRadius = 8
        imageView.sizeToFit()
        imageView.size = .init((Metric.cellHeight * 0.7).flat)
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.qmui_borderWidth = 1
        self.contentView.qmui_borderPosition = .bottom

        self.contentView.addSubview(self.avatarImageView)

        themeService.rx
            .bind({ $0.borderColor }, to: self.contentView.rx.qmui_borderColor)
            .disposed(by: self.rx.disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.avatarImageView.image = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.avatarImageView.left = 15
        self.avatarImageView.top = self.avatarImageView.topWhenCenter
    }

    func bind(reactor: UserItem) {
        super.bind(item: reactor)
        reactor.state.map { $0.avatar }
            .distinctUntilChanged { SWHub.compare($0, $1) }
            .bind(to: self.avatarImageView.rx.imageSource)
            .disposed(by: self.disposeBag)
        reactor.state.map { _ in }
            .bind(to: self.rx.setNeedsLayout)
            .disposed(by: self.disposeBag)
    }

    override class func size(width: CGFloat, item: BaseCollectionItem) -> CGSize {
//        guard let item = item as? RepoItem else { return .zero }
//        var height = UILabel.size(
//            attributedString: item.currentState.desc,
//            withConstraints: .init(width: UIScreen.width - 15 - 10, height: .greatestFiniteMagnitude),
//            limitedToNumberOfLines: 2
//        ).height
//        height += 10
//        height += Metric.iconSize.height
//        height += 5
//        height += 5
//        height += Metric.rankingSize.height
//        height += 5
//        return CGSize(width: width, height: height.flat)
        .init(width: width, height: Metric.cellHeight)
    }

}

