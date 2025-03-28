//
//  Room.swift
//  Chatwork
//
//  Created by Sora Oya on 2025/03/28.
//

import Foundation

public struct Room: Decodable {
    /// ルームID
    public let room_id: Int
    /// チャットの名前
    public let name: String
    /// チャットの種類
    public let type: ChatType
    /// 未読数
    public let unread_num: Int
    /// チャットのアイコン画像URL
    public let icon_path: String
    /// チャットが最後に更新された時刻。Unix時間（秒）
    public let last_update_time: Int
    
    public enum ChatType: String, CaseIterable, Decodable {
        case my = "my"
        case direct = "direct"
        case group = "group"
    }
}
