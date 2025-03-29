//
//  Message.swift
//  Chatwork
//
//  Created by Sora Oya on 2025/03/29.
//

import Foundation

public struct Message: Decodable {
    /// メッセージID
    public let message_id: String
    /// メッセージを投稿したアカウントの情報
    public let account: Account?
    /// メッセージ本文
    public let body: String?
    /// メッセージが送信された時刻。Unix時間（秒）
    public let send_time: Int?
    /// メッセージが最後に更新された時刻。Unix時間（秒）
    public let update_time: Int?
}

extension Message {
    public struct Account: Decodable {
        /// アカウントID
        public let account_id: Int
        /// 表示名
        public let name: String
        /// アバター画像URL
        public let avatar_image_url: String
    }
}
