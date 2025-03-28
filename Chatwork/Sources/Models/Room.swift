//
//  Room.swift
//  Chatwork
//
//  Created by Sora Oya on 2025/03/28.
//

import Foundation

struct Room: Hashable {
    /// ルームID
    let roomID: Int
    /// チャットの名前
    let name: String
    /// チャットの種類
    let type: ChatType
    /// 未読数
    let unreadNum: Int
    /// チャットのアイコン画像URL
    let iconPath: String
    /// チャットが最後に更新された時刻。Unix時間（秒）
    let lastUpdateTime: Int

    enum ChatType: String, CaseIterable {
        case my = "my"
        case direct = "direct"
        case group = "group"
    }
}
