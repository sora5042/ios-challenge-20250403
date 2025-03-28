//
//  UserAPI.swift
//  Chatwork
//
//  Created by Sora Oya on 2025/03/27.
//

import Foundation

public struct UserAPI: APIEndpoint {
    public init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    public let apiClient: APIClient
    public let path = "/me"

    /// 自分の情報を取得
    public func get() async throws -> User {
        try await apiClient.response(method: .get, path: path, parameters: nil)
    }
}
