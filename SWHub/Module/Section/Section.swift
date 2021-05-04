//
//  Section.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

enum Section {
    case sectionItems(header: String, items: [SectionItem])
}

extension Section: AnimatableSectionModelType {
    
    var identity: String {
        switch self {
        case let .sectionItems(header, _): return header // YJX_TODO header作为identity其实并不合适
        }
    }

    var items: [SectionItem] {
        switch self {
        case let .sectionItems(_, items): return items
        }
    }

    init(original: Section, items: [SectionItem]) {
        switch original {
        case let .sectionItems(header, _):
            self = .sectionItems(header: header, items: items)
        }
    }
    
}

enum SectionItem: IdentifiableType, Equatable {
    case simple(SimpleItem)
    case repo(RepoItem)
    case user(UserItem)
    case issue(IssueItem)

    var identity: String {
        switch self {
        case let .simple(item):
            return item.description
        case let .repo(item):
            return item.description
        case let .user(item):
            return item.description
        case let .issue(item):
            return item.description
        }
    }

    static func == (lhs: SectionItem, rhs: SectionItem) -> Bool {
        switch (lhs, rhs) {
        case let (.simple(left), .simple(right)):
            return left.description == right.description
        case let (.repo(left), .repo(right)):
            return left.description == right.description
        case let (.user(left), .user(right)):
            return left.description == right.description
        case let (.issue(left), .issue(right)):
            return left.description == right.description
        default: return false
        }
    }
    
}
