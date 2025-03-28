//
//  RoomsAPI.swift
//  Chatwork
//
//  Created by Sora Oya on 2025/03/28.
//

import Foundation

public struct RoomsAPI: APIEndpoint {
    public init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    public let apiClient: APIClient
    public let path = "/rooms"

    /// チャット一覧を取得する
    public func get() async throws -> [Room] {
        try await apiClient.response(method: .get, path: path, parameters: nil)
    }
}
