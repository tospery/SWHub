//
//  FeedbackNoteCell.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/29.
//

import UIKit

class FeedbackNoteCell: BaseCollectionCell, ReactorKit.View {
    
    let issuesSubject = PublishSubject<Void>()
    
    lazy var label: SWFLabel = {
        let label = SWFLabel.init(frame: .zero)
        label.delegate = self
        label.numberOfLines = 0
        label.verticalAlignment = .top
        let author = "\(Author.username)/\(Author.reponame)"
        let text = R.string.localizable.tipsFeedback(author)
        label.setText(text.styled(with: .color(.footer), .font(.normal(13))))
        let range = text.range(of: author)!
        let link = SWFLabelLink.init(
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.primary,
                NSAttributedString.Key.font: UIFont.normal(13)
            ],
            activeAttributes: [
                NSAttributedString.Key.foregroundColor: UIColor.red
            ],
            inactiveAttributes: [
                NSAttributedString.Key.foregroundColor: UIColor.gray
            ],
            textCheckingResult:
                .spellCheckingResult(
                    range: .init(
                        location: text.nsRange(from: range).location,
                        length: author.count)
                )
        )
        label.addLink(link)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.label)
        themeService.rx
            .bind({ $0.brightColor }, to: self.contentView.rx.backgroundColor)
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
        self.label.sizeToFit()
        self.label.width = self.contentView.width - 20 * 2
        self.label.height = self.contentView.height
        self.label.left = self.label.leftWhenCenter
        self.label.top = self.label.topWhenCenter
    }

    func bind(reactor: FeedbackNoteItem) {
        super.bind(item: reactor)
        reactor.state.map { _ in }
            .bind(to: self.rx.setNeedsLayout)
            .disposed(by: self.disposeBag)
    }
    
    override class func size(width: CGFloat, item: BaseCollectionItem) -> CGSize {
        .init(width: width, height: 40)
    }

}

extension FeedbackNoteCell: SWFLabelDelegate {

    func attributedLabel(_ label: SWFLabel!, didSelectLinkWith result: NSTextCheckingResult!) {
        self.issuesSubject.onNext(())
    }

}
