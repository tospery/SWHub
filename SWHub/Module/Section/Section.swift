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

extension Section: AnimatableSectionModelType, Equatable {
    
    var identity: String {
        switch self {
        case let .sectionItems(header, _): return header
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
    
    static func == (lhs: Section, rhs: Section) -> Bool {
        return (lhs.identity == rhs.identity) && (lhs.items == rhs.items)
    }

}

enum SectionItem: IdentifiableType, Equatable {
    case repo(RepoItem)
    case trendingUser(TrendingUserItem)
    case searchUser(SearchUserItem)
    case summaryRepo(SummaryRepoItem)
    case simple(SimpleItem)
    case issue(IssueItem)
    case theme(ThemeItem)
    case readmeRefresh(ReadmeRefreshItem)
    case readmeContent(ReadmeContentItem)
    case since(SinceItem)
    case language(LanguageItem)
    case summaryUser(SummaryUserItem)
    case app(AppItem)
    case scheme(SchemeItem)
    case logout(LogoutItem)
    case textField(TextFieldItem)
    case textView(TextViewItem)
    case button(ButtonItem)
    case feedbackInput(FeedbackInputItem)
    case feedbackNote(FeedbackNoteItem)
    case searchHistory(SearchHistoryItem)
    case empty(EmptyItem)

    var identity: String {
        var string = ""
        switch self {
        case .simple(let item): string = item.description
        case let .repo(item): string = item.description
        case let .summaryRepo(item): string = item.description
        case let .trendingUser(item): string = item.description
        case let .issue(item): string = item.description
        case let .readmeContent(item): string = item.description
        case let .readmeRefresh(item): string = item.description
        case let .since(item): string = item.description
        case let .language(item): string = item.description
        case let .summaryUser(item): string = item.description
        case let .app(item): string = item.description
        case let .scheme(item): string = item.description
        case let .logout(item): string = item.description
        case let .textField(item): string = item.description
        case let .textView(item): string = item.description
        case let .button(item): string = item.description
        case let .empty(item): string = item.description
        case let .theme(item): string = item.description
        case let .feedbackInput(item): string = item.description
        case let .feedbackNote(item): string = item.description
        case let .searchHistory(item): string = item.description
        case let .searchUser(item): string = item.description
        }
        return String.init(string.sorted())
    }

    static func == (lhs: SectionItem, rhs: SectionItem) -> Bool {
        let result = (lhs.identity == rhs.identity)
        if result == false {
            log("item变化:\n\(lhs.identity)\n\(rhs.identity)")
        }
        return result
    }
    
}
