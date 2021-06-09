//
//  IssueCell+Rx.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/18.
//

import Foundation
import TTGTagCollectionView

extension Reactive where Base: IssueCell {
    
    var labels: Binder<[Label]> {
        return Binder(self.base) { cell, labels in
            cell.tagsView.removeAllTags()
            let style = TTGTextTagStyle.init()
            style.shadowColor = .clear
            style.shadowOffset = .zero
            style.shadowRadius = 0
            style.shadowOpacity = 0
            style.extraSpace = .init(width: 15, height: 5)
            let content = TTGTextTagStringContent.init()
            content.textFont = .normal(13)
            content.textColor = .white
            for label in labels where label.name?.isEmpty ?? true == false {
                let tag = TTGTextTag.init()
                if let style = style.copy() as? TTGTextTagStyle,
                   let content = content.copy() as? TTGTextTagStringContent {
                    content.text = label.name!
                    if let color = label.color {
                        style.backgroundColor = UIColor.init(hexString: color) ?? .primary
                    }
                    tag.style = style
                    tag.content = content
                    cell.tagsView.addTag(tag)
                }
            }
            cell.tagsView.reload()
        }
    }
    
}
