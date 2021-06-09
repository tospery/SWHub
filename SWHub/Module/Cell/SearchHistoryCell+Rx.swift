//
//  SearchHistoryCell+Rx.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/6/4.
//

import Foundation
import TTGTagCollectionView

extension Reactive where Base: SearchHistoryCell {
    
    var clear: ControlEvent<Void> {
        self.base.clearButton.rx.tap
    }
    
    var word: ControlEvent<String> {
        let source = self.base.wordSubject.asObservable()
        return ControlEvent(events: source)
    }
    
    var words: Binder<[String]> {
        return Binder(self.base) { cell, words in
            cell.tagsView.removeAllTags()
            let style = TTGTextTagStyle.init()
            style.shadowColor = .clear
            style.shadowOffset = .zero
            style.shadowRadius = 0
            style.shadowOpacity = 0
            style.borderWidth = 0
            style.exactHeight = 26
            style.cornerRadius = style.exactHeight / 2
            style.extraSpace = .init(width: 30, height: 5)
            let content = TTGTextTagStringContent.init()
            content.textFont = .normal(13)
            content.textColor = .title
            for word in words where word.isEmpty == false {
                let tag = TTGTextTag.init()
                if let style = style.copy() as? TTGTextTagStyle,
                   let content = content.copy() as? TTGTextTagStringContent {
                    content.text = word
                    style.backgroundColor = .separator
                    tag.style = style
                    tag.content = content
                    cell.tagsView.addTag(tag)
                }
            }
            cell.tagsView.reload()
        }
    }
    
}
