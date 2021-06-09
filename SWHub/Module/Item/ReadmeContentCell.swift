//
//  ReadmeContentCell.swift
//  SWHub
//
//  Created by liaoya on 2021/5/11.
//

import UIKit
import MarkdownView

class ReadmeContentCell: BaseCollectionCell, ReactorKit.View {
    
    lazy var markdownView: MarkdownView = {
        let markdownView = MarkdownView()
        markdownView.isScrollEnabled = false
        return markdownView
    }()
    
    lazy var shadeView: UIView = {
        let view = UIView.init()
        view.sizeToFit()
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.markdownView.onRendered = { [weak self] height in
            guard let `self` = self else { return }
            if var readme = self.model as? Readme,
               readme.height == 0,
               let parent = self.reactor?.parent as? ListViewReactor {
                readme.height = height + 20
                var data = parent.currentState.data
                data.readme = readme
                parent.action.onNext(.data(data))
            }
        }
        self.contentView.addSubview(self.markdownView)
        self.contentView.addSubview(self.shadeView)
        themeService.rx
            .bind({ $0.brightColor }, to: self.shadeView.rx.backgroundColor)
            .disposed(by: self.disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.markdownView.sizeToFit()
        self.markdownView.frame = self.contentView.bounds
        self.shadeView.frame = self.contentView.bounds
    }

    func bind(reactor: ReadmeContentItem) {
        super.bind(item: reactor)
        reactor.state.map { $0.markdown }
            .distinctUntilChanged()
            .bind(to: self.rx.markdown)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.height != 0 }
            .distinctUntilChanged()
            .bind(to: self.shadeView.rx.isHidden)
            .disposed(by: self.disposeBag)
        reactor.state.map { _ in }
            .bind(to: self.rx.setNeedsLayout)
            .disposed(by: self.disposeBag)
    }

    override class func size(width: CGFloat, item: BaseCollectionItem) -> CGSize {
        guard let readme = (item as? ReadmeContentItem)?.model as? Readme else { return .zero }
        return .init(width: width, height: readme.height + 1)
    }

}

extension Reactive where Base: ReadmeContentCell {

    var markdown: Binder<String?> {
        return Binder(self.base) { cell, markdown in
            cell.markdownView.load(markdown: markdown)
        }
    }

}
