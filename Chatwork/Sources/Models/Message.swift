//
//  Message.swift
//  Chatwork
//
//  Created by Sora Oya on 2025/03/29.
//

import Foundation

struct Message: Hashable {
    /// メッセージID
    let messageID: String
    /// アカウントID
    let accountID: Int
    /// 表示名
    let accountName: String
    /// アイコン画像URL
    let iconImageURL: String
    /// メッセージ本文
    let message: String
    /// メッセージが送信された時刻。Unix時間（秒）
    let sendTime: Int
    /// メッセージが最後に更新された時刻。Unix時間（秒）
    let updateTime: Int
}
