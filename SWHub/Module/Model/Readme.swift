//
//  Readme.swift
//  SWHub
//
//  Created by liaoya on 2021/5/11.
//

import Foundation

struct Readme: ModelType, Subjective, Eventable {

    enum Event {
        case height(CGFloat)
    }
    
    var id = ""
    var links: Link?
    var content: String?
    var downloadUrl: String?
    var encoding: String?
    var gitUrl: String?
    var htmlUrl: String?
    var name: String?
    var path: String?
    var size: Int?
    var type: String?
    var url: String?
    var height = 0.f
    
    var sha: String {
        self.id
    }
    
    var markdown: String? {
        // ![Banner](img/banner.png)
        // <img src="/img/900Mhardware.jpg" width = "80%">
        // ![day](./public/screenshots/day.png)  -> "](./"
        // 验证的 Front-End-Checklist ->
        // https://raw.githubusercontent.com/thedaviddias/Front-End-Checklist/master/README.md
        // 1. sindresorhus/awesome
        // https://raw.githubusercontent.com/sindresorhus/awesome/main/readme.md
        guard let content = self.content else { return nil }
        guard let data = Data.init(base64Encoded: content, options: .ignoreUnknownCharacters) else { return nil }
        guard let markdown = String.init(data: data, encoding: .utf8) else { return nil }
        return markdown
//        guard self.downloadUrl != nil else { return nil }
//        var string = self.downloadUrl!
//        var regExp = try! NSRegularExpression.init(pattern: "(.*?)README.md$", options: .caseInsensitive)
//        guard let base = regExp.firstMatchString(
//                in: string,
//                range: string.startIndex..<string.endIndex,
//                at: 1
//        ) else { return markdown }
//        string = markdown
//        regExp = try! NSRegularExpression.init(pattern: "((?!https?:)[./]*(.*?.(?:png|jpg|svg)))")
//        let mutableString = NSMutableString.init(string: string)
//        regExp.replaceMatches(
//            in: mutableString,
//            range: .init(location: 0, length: mutableString.length),
//            withTemplate: "(\(base)$1)"
//        )
//        regExp = try! NSRegularExpression.init(pattern: """
//            src=("|')(?!https?:)[./]*(.*?.(?:png|jpg|svg))\\1
//            """)
//        regExp.replaceMatches(
//            in: mutableString,
//            range: .init(location: 0, length: mutableString.length),
//            withTemplate: "src=$1\(base)$2$1"
//        )
//        return mutableString as String
    }

    init() { }

    init?(map: Map) { }

    mutating func mapping(map: Map) {
        id              <- map["sha"]
        links           <- map["_links"]
        content         <- map["content"]
        downloadUrl     <- map["download_url"]
        encoding        <- map["encoding"]
        gitUrl          <- map["git_url"]
        htmlUrl         <- map["html_url"]
        name            <- map["name"]
        path            <- map["path"]
        size            <- map["size"]
        type            <- map["type"]
        url             <- map["url"]
        height          <- map["height"]
    }

}
