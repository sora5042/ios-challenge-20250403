//
//  User.swift
//  Chatwork
//
//  Created by Sora Oya on 2025/03/28.
//

import Foundation

struct User: Hashable {
    /// アカウントID
    let accountID: Int
    /// ルームID
    let roomID: Int
    /// 表示名
    let name: String
    /// Chatwork ID
    let chatworkID: String
    /// 組織ID
    let organizationID: Int?
    /// 組織名
    let organizationName: String?
    /// 所属
    let department: String?
    /// 役職
    let title: String?
    /// 自己紹介
    let introduction: String?
    /// メールアドレス
    let mail: String?
    /// アバター画像URL
    let avatarImageURL: String
    /// Chatwork登録メールアドレス（ログインメールアドレス）
    let loginMail: String
}
