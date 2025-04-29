//
//  AppDelegate.swift
//  swift-universal-link
//
//  Created by 정희수 on 4/29/25.
//

import Foundation

enum UniversalLinkType: Codable {
    case home                           // 홈
    case today                          // 투데이
    case contents(_ id: String)         // 콘텐츠
    
    private static var fallback: UniversalLinkType { .home }   // 잘못된 값이 들어온 경우
    
    // urlString 예시
    // https://domain.com/contents?id=1
    init?(urlString: String) {
        guard let urlComponents = URLComponents(string: urlString) else {
            self = Self.fallback
            return
        }
        
        let path = urlComponents.path
        let queryItems = urlComponents.queryItems
        
        switch path {
        case "/home":
            self = .home
        case "/today":
            self = .today
        case "/contents":
            guard let id = queryItems?.first(where: { $0.name == "id"})?.value else {
                self = Self.fallback
                return
            }
            
            self = .contents(id)
        default:
            self = Self.fallback
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case path, id
    }

    enum PathCodingKeys: String, Codable {
        case home, today, contents
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .home:
            try container.encode(PathCodingKeys.home, forKey: .path)
        case .today:
            try container.encode(PathCodingKeys.today, forKey: .path)
        case .contents(let id):
            try container.encode(PathCodingKeys.contents, forKey: .path)
            try container.encode(id, forKey: .id)
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let path = try container.decode(PathCodingKeys.self, forKey: .path)

        switch path {
        case .home:
            self = .home
        case .today:
            self = .today
        case .contents:
            let id = try container.decode(String.self, forKey: .id)
            self = .contents(id)
        }
    }
}
