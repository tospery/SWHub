//
//  Repo+Ex.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/12.
//

import Foundation
import DateToolsSwift_JX

extension Repo {
    
//    enum Portal: Int {
//        case language
//        case branches
//        case issues
//        case pulls
//        // case readme
//
//        static let allValues = [language, branches, issues, pulls]
//
//        var title: String? {
//            switch self {
//            case .branches: return R.string.localizable.branches()
//            case .issues: return R.string.localizable.issues()
//            case .pulls: return R.string.localizable.pulls()
//            default: return nil
//            }
//        }
//
//        var icon: UIImage {
//            switch self {
//            case .language: return R.image.repo_language()!
//            case .branches: return R.image.repo_branch()!
//            case .issues: return R.image.issues()!
//            case .pulls: return R.image.repo_pulls()!
//            }
//        }
//
//    }
    
    var isValid: Bool {
        self.name.isEmpty == false &&
        self.url?.isEmpty ?? true == false
    }
    
//    func models(
//        withBranchs branches: [Branch],
//        withPulls pulls: [Pull]) -> [ModelType] {
//        Portal.allValues.map { portal -> Simple in
//            switch portal {
//            case .language:
//                return Simple.init(
//                    id: portal.rawValue,
//                    icon: portal.icon,
//                    title: portal.title ?? self.language ?? R.string.localizable.unknown(),
//                    detail: "\(self.size.kilobytesText)(\(self.license?.spdxId ?? R.string.localizable.none()))"
//                        .styled(with: .font(.normal(14)), .color(.body))
//                )
//            case .branches:
//                return Simple.init(
//                    id: portal.rawValue,
//                    icon: portal.icon,
//                    title: portal.title,
//                    detail: "\(branches.count)(\(self.defaultBranch ?? R.string.localizable.none()))"
//                        .styled(with: .font(.normal(14)), .color(.body))
//                )
//            case .issues:
//                return Simple.init(
//                    id: portal.rawValue,
//                    icon: portal.icon,
//                    title: portal.title,
//                    detail: self.openIssuesCount.string
//                        .styled(with: .font(.normal(14)), .color(.body))
//                )
//            case .pulls:
//                return Simple.init(
//                    id: portal.rawValue,
//                    icon: portal.icon,
//                    title: portal.title,
//                    detail: pulls.count.string
//                        .styled(with: .font(.normal(14)), .color(.body))
//                )
//            }
//        }
//    }
    
    var statusText: String? {
        if self.currentPeriodStars != nil {
            return self.starsStyle3
        }
        return self.updateAgo
    }
    
    var languageWithDefault: String {
        self.language ?? R.string.localizable.unknown()
    }
    
    var sizeStyle: String {
        "\(self.size.kilobytesText)(\(self.license?.spdxId ?? R.string.localizable.none()))"
    }
    
    var updateAgo: String? {
        guard let string = self.updatedAt else { return nil }
        guard let date = Date.init(iso8601: string) else { return nil }
        return R.string.localizable.repoUpdate(date.timeAgoSinceNow)
    }
    
    var descAttributedText: NSAttributedString {
        (self.desc ?? R.string.localizable.noneDesc())
            .styled(with: .font(Metric.Trending.descFont), .color(.body), .lineSpacing(1))
    }
    
    var watchesAttributedText: NSAttributedString {
        NSAttributedString.composed(of: [
            (self.watchers.decimalText ?? "0")
                .styled(with: .font(.bold(16)), .color(.primary)),
            Special.nextLine,
            R.string.localizable.watches()
                .styled(with: .font(.normal(13)), .color(.body))
        ]).styled(with: .alignment(.center))
    }
    
    var forksAttributedText: NSAttributedString {
        NSAttributedString.composed(of: [
            (self.forks.decimalText ?? "0")
                .styled(with: .font(.bold(16)), .color(.primary)),
            Special.nextLine,
            R.string.localizable.forks()
                .styled(with: .font(.normal(13)), .color(.body))
        ]).styled(with: .alignment(.center))
    }
    
    var languageStyle: NSAttributedString {
        NSAttributedString.composed(of: [
            "●".styled(with: .color(self.languageColor?.color ?? .random)),
            Special.space,
            (self.language ?? R.string.localizable.unknown()).styled(with: .color(.title))
        ]).styled(with: .font(.normal(13)))
    }
    
    var starsStyle1: NSAttributedString {
        NSAttributedString.composed(of: [
            R.image.star()!.template.styled(with: .baselineOffset(-2), .color(.primary)),
            Special.space,
            self.stars.formatted.styled(with: .color(.title))
        ]).styled(with: .font(.normal(11)))
    }
    
    var starsStyle2: NSAttributedString {
        NSAttributedString.composed(of: [
            (self.stars.decimalText ?? "0")
                .styled(with: .font(.bold(16)), .color(.primary)),
            Special.nextLine,
            R.string.localizable.stars()
                .styled(with: .font(.normal(13)), .color(.body))
        ]).styled(with: .alignment(.center))
    }
    
    var starsStyle3: String {
        R.string.localizable.repoCurrentPeriodStars((self.currentPeriodStars ?? 0).string)
    }
    
    var descStyle: NSAttributedString? {
        (self.desc ?? R.string.localizable.noneDesc()).styled(
            with: .font(.normal(15)),
            .lineHeightMultiple(1.1),
            .lineBreakMode(.byTruncatingTail)
        )
    }
    
}
