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
    public func getRooms() async throws -> [Room] {
        try await apiClient.response(method: .get, path: path, parameters: nil)
    }

    /// チャット情報を取得する
    public func getRoom(_ id: Int) async throws -> Room {
        try await apiClient.response(method: .get, path: path + "/\(id)", parameters: nil)
    }

    /// チャットメッセージを取得する
    public func getMessages(_ param: GetParam, id: Int) async throws -> [Message] {
        try await apiClient.response(method: .get, path: path + "/\(id)" + "/messages", parameters: param)
    }
}

extension RoomsAPI {
    // Getリクエスト用パラメータ
    public struct GetParam: Encodable {
        public init(force: Int? = nil) {
            self.force = force
        }

        /// 強制的に最大件数まで取得するかどうか。0を指定した場合（既定）は前回取得分からの差分のみ。
        /// 1を指定した場合は最新のメッセージを最大100件まで取得。
        public var force: Int?
    }
}
