//
//  RepoCell+Rx.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/30.
//

import Foundation

extension Reactive where Base: RepoCell {
    
    var ranking: Binder<String?> {
        self.base.rankingLabel.rx.text
    }
    
    var status: Binder<String?> {
        self.base.statusLabel.rx.text
    }
    
    var stars: Binder<NSAttributedString?> {
        self.base.starsLabel.rx.attributedText
    }
    
    var language: Binder<NSAttributedString?> {
        self.base.languageLabel.rx.attributedText
    }
    
    var desc: Binder<NSAttributedString?> {
        self.base.descLabel.rx.attributedText
    }
    
    var reponame: Binder<String?> {
        return Binder(self.base) { cell, text in
            cell.reponameLabel.setText(text)
            guard let string = text else { return }
            guard let range = string.range(of: "/") else { return }
            let username = String.init(string[string.startIndex..<string.index(before: range.upperBound)])
            guard !username.isEmpty else { return }
            let link = SWFLabelLink.init(
                attributes: [
                    NSAttributedString.Key.foregroundColor: UIColor.title
                ],
                activeAttributes: [
                    NSAttributedString.Key.foregroundColor: UIColor.primary,
                    NSAttributedString.Key.font: UIFont.normal(17)
                ],
                inactiveAttributes: [
                    NSAttributedString.Key.foregroundColor: UIColor.gray
                ],
                textCheckingResult:
                    .spellCheckingResult(
                        range: .init(
                            location: 0,
                            length: username.count)
                    )
            )
            cell.reponameLabel.addLink(link)
        }
    }
    
    var tapUser: ControlEvent<String> {
        let source = self.base.usernameSubject
        return ControlEvent(events: source)
    }
    
//    var tapUsername: ControlEvent<String> {
//        let source = self.base.usernameLabel.rx.tapGesture().when(.recognized)
//            .map { ($0.view as? UILabel)?.text ?? "" }
//        return ControlEvent(events: source)
//    }
//
//    var username: Binder<String?> {
//        self.base.usernameLabel.rx.text
//    }

//    var username: Binder<NSAttributedString?> {
//        return Binder(self.base) { cell, attributedText in
//            cell.usernameLabel.setText(attributedText)
//            guard let string = attributedText?.string,
//                  string.contains("/") else { return }
//            guard let range = string.range(of: "/") else { return }
//            let username = String.init(string[string.startIndex..<string.index(before: range.upperBound)])
//            guard !username.isEmpty else { return }
//            let link = SWFLabelLink.init(
//                attributes: [
//                    NSAttributedString.Key.foregroundColor: UIColor.primary,
//                    NSAttributedString.Key.font: UIFont.normal(17)
//                ],
//                activeAttributes: [
//                    NSAttributedString.Key.foregroundColor: UIColor.red
//                ],
//                inactiveAttributes: [
//                    NSAttributedString.Key.foregroundColor: UIColor.gray
//                ],
//                textCheckingResult:
//                    .spellCheckingResult(
//                        range: .init(
//                            location: 0,
//                            length: username.count)
//                    )
//            )
//            cell.usernameLabel.addLink(link)
//        }

        
}
