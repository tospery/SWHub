//
//  Router.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

struct Router {
    
    typealias URLScheme = (
        name: String,
        pattern: String,
        queries: [String]
    )

    static func urlPattern(host: Host) -> String {
        switch host {
        case .repo:
            return "\(UIApplication.shared.urlScheme)://\(host.rawValue)/<username>/<reponame>"
        case .repos, .users, .search, .popup:
            return "\(UIApplication.shared.urlScheme)://\(host.rawValue)/<type:_>"
        case .feedback, .user:
            // 需要指定用户username的条件
            // 1. 暴露的urlScheme，需要用户登录的
            // 2. 未暴露的urlScheme，未登录时有触发场景的
            return "\(UIApplication.shared.urlScheme)://\(host.rawValue)/<username>"
        default:
            return "\(UIApplication.shared.urlScheme)://\(host.rawValue)"
        }
    }
    
    static func urlString(host: Host) -> String {
        self.urlPattern(host: host)
            .replacingOccurrences(of: "/<username>", with: "")
            .replacingOccurrences(of: "/<reponame>", with: "")
            .replacingOccurrences(of: "/<type:_>", with: "")
    }
    
    /// 暴露的URL Schemes
    static func exportedURLSchemes() -> [URLScheme] {
        var exported = [URLScheme].init()
        exported.append((
            name: "User",
            pattern: self.urlPattern(host: .user),
            queries: []
        ))
        exported.append((
            name: "Repo",
            pattern: self.urlPattern(host: .repo),
            queries: []
        ))
        return exported
    }
    
    // swiftlint:disable function_body_length cyclomatic_complexity
    static func parameters(
        _ url: URLConvertible,
        _ values: [String: Any],
        _ context: Any?
    ) -> [String: Any]? {
        // 1. 基础参数
        var parameters: [String: Any] = url.queryParameters
        for (key, value) in values {
            parameters[key] = value
        }
        if let context = context {
            parameters[Parameter.context] = context
        }
        // 2. Host
        guard let host = Host.init(rawValue: url.urlValue?.host ?? "") else { return nil }
        parameters[Parameter.host] = host.rawValue
        // 3. Path
        let pathValue = url.urlValue?.path.removingPrefix("/").removingSuffix("/")
        let pathParam = Path.init(rawValue: pathValue ?? "")
        parameters[Parameter.path] = pathParam?.rawValue ?? pathValue
        // 4. 默认参数
        var shouldRefresh = host.isList
        var shouldLoadMore = host.isList
        parameters[Parameter.title] = stringMember(parameters, Parameter.title, host.title)
        
        // 3. 特殊处理（定制默认参数、检查参数名/值）
        switch host {
        case .users, .repos:
            switch pathParam {
            case .trending:
                shouldLoadMore = false
                parameters[Parameter.hideNavBar] = boolMember(parameters, Parameter.hideNavBar, true)
            case .stars:
                parameters[Parameter.title] = R.string.localizable.stars()
            default:
                break
            }
        case .center:
            shouldRefresh = true
        case .user:
            guard (parameters[Parameter.username] as? String) != nil else { return nil }
            shouldRefresh = true
        case .repo:
            guard let pathArray = pathValue?.components(separatedBy: "/") else { return nil }
            guard pathArray.count == 2 else { return nil }
            parameters[Parameter.username] = pathArray[0]
            parameters[Parameter.reponame] = pathArray[1]
            shouldRefresh = true
        case .modify:
            guard stringMember(parameters, Parameter.portal, nil) != nil else { return nil }
        default:
            break
        }
        parameters[Parameter.shouldRefresh] = boolMember(parameters, Parameter.shouldRefresh, shouldRefresh)
        parameters[Parameter.shouldLoadMore] = boolMember(parameters, Parameter.shouldLoadMore, shouldLoadMore)
        return parameters
    }
    // swiftlint:enable function_body_length cyclomatic_complexity
    
    static func initialize(_ provider: SWFrame.ProviderType, _ navigator: NavigatorType) {
        navigator.matcher.valueConverters["type"] = { pathComponents, index in
            guard let host = Host.init(rawValue: pathComponents[0]) else { return nil }
            let allowedPaths = host.allowedPaths.map { $0.rawValue }
            if allowedPaths.contains(pathComponents[index]) {
                return pathComponents[index]
            }
            return nil
        }
        self.web(provider, navigator)
        self.page(provider, navigator)
        self.model(provider, navigator)
    }
    
}
