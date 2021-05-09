//
//  ProfileViewReactor+Portal.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/9.
//

import Foundation

extension ProfileViewReactor {
    
    enum Portal: Int {
        case name, intro, team, address, homepage

        static let allSections = [[name, intro], [team, address, homepage]]

        var title: String {
            switch self {
            case .name: return R.string.localizable.profilePortalName()
            case .intro: return R.string.localizable.profilePortalIntro()
            case .team: return R.string.localizable.profilePortalTeam()
            case .address: return R.string.localizable.profilePortalAddress()
            case .homepage: return R.string.localizable.profilePortalHomepage()
            }
        }
        
        var detail: NSAttributedString? {
            let user = User.current
            var string: String?
            switch self {
            case .name: string = user?.name
            case .intro: string = user?.bio
            case .team: string = user?.company
            case .address: string = user?.location
            case .homepage: string = user?.blog
            }
            return string?.styled(with: .font(.systemFont(ofSize: 15)), .color(.body))
        }
        
    }
    
}
