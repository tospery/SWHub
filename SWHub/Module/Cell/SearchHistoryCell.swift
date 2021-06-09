//
//  SearchHistoryCell.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/6/4.
//

import UIKit
import TTGTagCollectionView

class SearchHistoryCell: BaseCollectionCell, ReactorKit.View {
    
    struct Metric {
        static let topHeight = 60.f
    }
    
    let wordSubject = PublishSubject<String>()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel.init()
        label.font = .normal(14)
        label.text = R.string.localizable.searchHistoryTitle()
        label.sizeToFit()
        return label
    }()
    
    lazy var clearButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.titleLabel?.font = .normal(13)
        button.setTitle(R.string.localizable.clear(), for: .normal)
        button.sizeToFit()
        return button
    }()
    
    lazy var topView: UIView = {
        let view = UIView.init()
        view.sizeToFit()
        view.height = Metric.topHeight
        return view
    }()
    
    lazy var tagsView: TTGTextTagCollectionView = {
        let view = TTGTextTagCollectionView.init()
        view.delegate = self
        view.numberOfLines = 2
        view.contentInset = .init(top: 4, left: 20, bottom: 2, right: 20)
        view.sizeToFit()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.topView)
        self.topView.addSubview(self.titleLabel)
        self.topView.addSubview(self.clearButton)
        self.contentView.addSubview(self.tagsView)
        
        themeService.rx
            .bind({ $0.brightColor }, to: [
                self.contentView.rx.backgroundColor,
                self.topView.rx.backgroundColor,
                self.tagsView.rx.backgroundColor
            ])
            .bind({ $0.foregroundColor }, to: self.titleLabel.rx.textColor)
            .bind({ $0.bodyColor }, to: self.clearButton.rx.titleColor(for: .normal))
            .disposed(by: self.rx.disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.tagsView.removeAllTags()
        self.tagsView.reload()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.topView.width = self.contentView.width
        self.topView.left = 0
        self.topView.top = 0
        self.titleLabel.left = 10
        self.titleLabel.top = self.titleLabel.topWhenCenter
        self.clearButton.right = self.contentView.width - 10
        self.clearButton.top = self.clearButton.topWhenCenter
        self.tagsView.width = self.contentView.width
        self.tagsView.height = self.contentView.height - self.topView.height
        self.tagsView.left = 0
        self.tagsView.top = self.topView.height
    }

    func bind(reactor: SearchHistoryItem) {
        super.bind(item: reactor)
        reactor.state.map { $0.words }
            .distinctUntilChanged()
            .bind(to: self.rx.words)
            .disposed(by: self.disposeBag)
        reactor.state.map { _ in }
            .bind(to: self.rx.setNeedsLayout)
            .disposed(by: self.disposeBag)
    }

    override class func size(width: CGFloat, item: BaseCollectionItem) -> CGSize {
        .init(width: width, height: 140)
    }

}

extension SearchHistoryCell: TTGTextTagCollectionViewDelegate {
    func textTagCollectionView(
        _ textTagCollectionView: TTGTextTagCollectionView!,
        didTap tag: TTGTextTag!,
        at index: UInt
    ) {
        guard let content = tag.content as? TTGTextTagStringContent else { return }
        self.wordSubject.onNext(content.text)
    }
}
