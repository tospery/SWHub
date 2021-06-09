//
//  SimpleCell.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import UIKit

class SimpleCell: BaseCollectionCell, ReactorKit.View {

    lazy var titleLabel: SWFLabel = {
        let label = SWFLabel.init(frame: .zero)
        label.font = .normal(16)
        label.sizeToFit()
        return label
    }()

    lazy var detailLabel: SWFLabel = {
        let label = SWFLabel.init(frame: .zero)
        label.font = .normal(14)
        label.textAlignment = .right
        label.sizeToFit()
        return label
    }()

    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.sizeToFit()
        return imageView
    }()

    lazy var indicatorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.indicator.template
        imageView.sizeToFit()
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.borderLayer?.borders = .bottom
        self.borderLayer?.borderColors = [BorderLayer.Border.bottom: UIColor.separator]
        self.borderLayer?.borderWidths = [BorderLayer.Border.bottom: pixelOne]
        self.borderLayer?.borderInsets = [BorderLayer.Border.bottom: (15, 0)]

        self.contentView.addSubview(self.iconImageView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.detailLabel)
        self.contentView.addSubview(self.indicatorImageView)

        themeService.rx
            .bind({ $0.titleColor }, to: self.titleLabel.rx.textColor)
            .bind({ $0.headerColor }, to: self.detailLabel.rx.textColor)
            .bind({ $0.primaryColor }, to: [
                self.iconImageView.rx.tintColor,
                self.indicatorImageView.rx.tintColor
            ])
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
        self.detailLabel.text = nil
        self.iconImageView.image = nil
        self.indicatorImageView.isHidden = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.iconImageView.sizeToFit()
        self.iconImageView.left = 15
        self.iconImageView.top = self.iconImageView.topWhenCenter

        self.titleLabel.sizeToFit()
        self.titleLabel.left = self.iconImageView.right + 10
        self.titleLabel.top = self.titleLabel.topWhenCenter

        self.indicatorImageView.right = self.contentView.width - 10
        self.indicatorImageView.top = self.indicatorImageView.topWhenCenter

        self.detailLabel.sizeToFit()
        self.detailLabel.right = self.indicatorImageView.isHidden ?
            self.indicatorImageView.centerX :
            self.indicatorImageView.left - 8
        self.detailLabel.top = self.detailLabel.topWhenCenter
        
        if self.titleLabel.right >= self.detailLabel.left {
            self.titleLabel.extendToRight = self.detailLabel.left - 8
        }
    }

    func bind(reactor: SimpleItem) {
        super.bind(item: reactor)
        if let parent = reactor.parent as? ListViewReactor,
           let simple = reactor.model as? Simple,
           let portal = Portal.init(rawValue: simple.id),
           let identifier = simple.identifier {
            switch identifier {
            case .userDetail:
                self.userDetail(reactor: reactor, parent: parent, portal: portal)
            case .userProfile:
                self.userProfile(reactor: reactor, parent: parent, portal: portal)
            case .repoDetail:
                self.repoDetail(reactor: reactor, parent: parent, portal: portal)
            }
        }
        reactor.state.map { $0.title }
            .distinctUntilChanged()
            .bind(to: self.titleLabel.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.detail }
            .bind(to: self.detailLabel.rx.attributedText)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.icon }
            .distinctUntilChanged { SWFrame.compareImage($0, $1) }
            .bind(to: self.iconImageView.rx.imageResource(placeholder: R.image.default_avatar()))
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.icon == nil }
            .bind(to: self.iconImageView.rx.isHidden)
            .disposed(by: self.disposeBag)
        reactor.state.map { !$0.indicated }
            .bind(to: self.indicatorImageView.rx.isHidden)
            .disposed(by: self.disposeBag)
        reactor.state.map { _ in }
            .bind(to: self.rx.setNeedsLayout)
            .disposed(by: self.disposeBag)
    }
    
    func userDetail(reactor: SimpleItem, parent: ListViewReactor, portal: Portal) {
        var title: Observable<String?>?
        switch portal {
        case .company:
            title = parent.state.map { $0.user?.companyWithDefault }
        case .location:
            title = parent.state.map { $0.user?.locationWithDefault }
        case .email:
            title = parent.state.map { $0.user?.emailWithDefault }
        case .blog:
            title = parent.state.map { $0.user?.blogWithDefault }
        default:
            break
        }
        title?.distinctUntilChanged()
            .map { Reactor.Action.title($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
    
    func userProfile(reactor: SimpleItem, parent: ListViewReactor, portal: Portal) {
        var detail: Observable<String?>?
        switch portal {
        case .name:
            detail = parent.state.map { $0.user?.nickname }
        case .bio:
            detail = parent.state.map { $0.user?.bio }
        case .company:
            detail = parent.state.map { $0.user?.company }
        case .location:
            detail = parent.state.map { $0.user?.location }
        case .blog:
            detail = parent.state.map { $0.user?.blog }
        default:
            break
        }
        detail?.distinctUntilChanged().map { $0?.styled(with: .color(.body), .font(.normal(15))) }
            .map { Reactor.Action.detail($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
    
    func repoDetail(reactor: SimpleItem, parent: ListViewReactor, portal: Portal) {
        var title: Observable<String?>?
        var detail: Observable<String?>?
        switch portal {
        case .language:
            title = parent.state.map { $0.data.repo?.languageWithDefault }
            detail = parent.state.map { $0.data.repo?.sizeStyle }
        case .issues:
            detail = parent.state.map { ($0.data.repo?.openIssuesCount ?? 0).string }
        case .pulls:
            detail = parent.state.map { $0.data.pulls.count.string }
        case .branches:
            detail = parent.state.map {
                "\($0.data.branches.count)(\($0.data.repo?.defaultBranch ?? R.string.localizable.none()))"
            }
        default:
            break
        }
        title?.distinctUntilChanged()
            .map { Reactor.Action.title($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        detail?.distinctUntilChanged()
            .map { $0?.styled(with: .color(.body), .font(.normal(15))) }
            .map { Reactor.Action.detail($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }

    override class func size(width: CGFloat, item: BaseCollectionItem) -> CGSize {
        return CGSize(width: width, height: 50)
    }

}
