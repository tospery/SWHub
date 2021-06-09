//
//  User+Ex.swift
//  SWHub
//
//  Created by liaoya on 2021/5/21.
//

import Foundation

extension User {
    
    var isValid: Bool {
        self.id != 0 &&
            self.username.isEmpty == false
    }
    
    var companyWithDefault: String {
        guard self.company?.isEmpty ?? true == false else {
            return R.string.localizable.noneCompany()
        }
        return self.company!
    }
    
    var locationWithDefault: String {
        guard self.location?.isEmpty ?? true == false else {
            return R.string.localizable.noneLocation()
        }
        return self.location!
    }
    
    var emailWithDefault: String {
        guard self.email?.isEmpty ?? true == false else {
            return R.string.localizable.noneEmail()
        }
        return self.email!
    }
    
    var blogWithDefault: String {
        guard self.blog?.isEmpty ?? true == false else {
            return R.string.localizable.noneBlog()
        }
        return self.blog!
    }
    
    var profileName: NSAttributedString {
        NSAttributedString.composed(of: [
            self.username.styled(with: .color(.primary)),
            self.username.styled(with: .color(.title))
        ]).styled(with: .font(.normal(20)))
    }
    
    var nameStyle: NSAttributedString {
        if self.nickname?.isEmpty ?? true {
            return self.username.styled(with: .font(.normal(17)), .color(.title))
        }
        return NSAttributedString.composed(of: [
            self.nickname!.attributedString(),
            Special.space,
            "(\(self.username))".attributedString()
        ]).styled(with: .font(.normal(17)), .color(.title))
    }
    
    var joinedStyle: String? {
        guard let string = self.createdAt else { return nil }
        guard let date = Date.init(iso8601: string) else { return nil }
        let value = date.string(withFormat: "yyyy-MM-dd")
        return R.string.localizable.userJoined(value)
    }
    
    var reponameStyle: NSAttributedString {
        NSAttributedString.composed(of: [
            R.image.repo_small()!.styled(with: .baselineOffset(-3)),
            Special.space,
            (self.repo?.name ?? R.string.localizable.noneRepo()).attributedString()
        ]).styled(with: .color(.title), .font(.normal(15)))
    }
    
    var repodescStyle: NSAttributedString {
        (self.repo?.desc ?? R.string.localizable.noneDesc())
            .styled(with: .color(.body), .font(Metric.Trending.descFont), .lineSpacing(1))
    }
    
    var repositoriesStyle: NSAttributedString {
        let total = self.publicRepos + self.totalPrivateRepos
        return NSAttributedString.composed(of: [
            total.string.styled(with: .color(.primary), .font(.normal(20))),
            Special.nextLine,
            R.string.localizable.repositories().styled(with: .color(.body), .font(.normal(14)))
        ]).styled(with: .alignment(.center))
    }
    
    var followersStyle: NSAttributedString {
        NSAttributedString.composed(of: [
            self.followers.string.styled(with: .color(.primary), .font(.normal(20))),
            Special.nextLine,
            R.string.localizable.followers().styled(with: .color(.body), .font(.normal(14)))
        ]).styled(with: .alignment(.center))
    }
    
    var followingStyle: NSAttributedString {
        NSAttributedString.composed(of: [
            self.following.string.styled(with: .color(.primary), .font(.normal(20))),
            Special.nextLine,
            R.string.localizable.following().styled(with: .color(.body), .font(.normal(14)))
        ]).styled(with: .alignment(.center))
    }
    
}
